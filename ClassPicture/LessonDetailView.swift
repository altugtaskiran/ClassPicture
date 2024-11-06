import SwiftUI

struct LessonDetailView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var isCameraPresented = false
    @State private var images: [UIImage] = []
    @State var lesson: Lesson
    @State private var isImagePreviewPresented = false

    init(lesson: Lesson) {
        _lesson = State(initialValue: lesson)
    }

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HStack {
                    Text(lesson.name)
                        .font(.largeTitle)
                        .padding(.leading)
                        .foregroundColor(.black)

                    Spacer()
                }

                HStack {
                    Spacer()

                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                                .foregroundColor(.blue)
                            Text("Gallery")
                                .foregroundColor(.blue)

                        }
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(image: $selectedImage, onImagePicked: { image in
                            self.addImage(image)
                        })
                    }

                    Button(action: {
                        isCameraPresented = true
                    }) {
                        HStack {
                            Image(systemName: "camera")
                                .foregroundColor(.blue)

                            Text("Camera")
                                .foregroundColor(.blue)

                        }
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $isCameraPresented) {
                        CameraPicker(image: $selectedImage, onImagePicked: { image in
                            self.addImage(image)
                        })
                    }
                }
            }
            .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                    ForEach(images, id: \.self) { image in
                        GeometryReader { geometry in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .clipped()
                                .onTapGesture {
                                    selectedImage = image
                                    isImagePreviewPresented = true
                                }
                        }
                        .frame(height: UIScreen.main.bounds.width / 3)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            loadImages()
        }
        .sheet(isPresented: $isImagePreviewPresented) {
            if let selectedImage = selectedImage {
                ImagePreview(image: selectedImage)
            }
        }
    }

    private func addImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)

        do {
            try data.write(to: url)
            lesson.images.append(filename)
            images.append(image)
            saveLesson()
        } catch {
            print("Unable to save image to disk: \(error.localizedDescription)")
        }
    }

    private func loadImages() {
        images = lesson.images.compactMap { filename in
            let url = getDocumentsDirectory().appendingPathComponent(filename)
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                return nil
            }
            return image
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    private func saveLesson() {
        LessonAddManager.shared.updateLesson(lesson)
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView(lesson: Lesson(
            name: "Math",
            day: "Monday",
            startTime: "10:00",
            endTime: "11:00",
            isActive: true,
            images: []
        ))
    }
}

