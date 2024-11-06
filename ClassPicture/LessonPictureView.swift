/* import SwiftUI
import PhotosUI

struct LessonPictureView: View {
  var lesson: Lesson // Lesson'ın aktarıldığını varsayarak

  var lessonTitle: String {
    return lesson.name
  }

  @State private var showImageGrid = false
  @State private var selectedImages: [UIImage] = [] // Seçilen görüntüleri depolamak için
  @State private var images: [Image] = [] // Görüntüleri depolamak için (kullanıcı arayüzünde görüntülenen)
  @State private var showHome = false
  @State private var error: Error? = nil // Olası hataları depolamak için

  var body: some View {
    VStack {
      HStack {
        // Gezinme bağlantısı ile geri düğmesi
        Image(systemName: "arrow.uturn.backward")
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(.black)
          .onTapGesture {
            showHome.toggle()
          }
          .fullScreenCover(isPresented: $showHome) {
            ContentView()
          }
          .offset(x: 5)

        Spacer()

        Text(lessonTitle)
          .font(.title)
          .foregroundColor(.black)
      }
      .padding()

      Spacer()

      // Fotoğraf Ekle düğmesi
      Button(action: {
        // Görüntü seçme işlemini başlat
          let imagePicker = PHPickerViewController(configuration: .init())
          let imagePhotoPicker = ImagePhotoPicker { images in
              print(images)
              // 	lesson.images.append(contentsOf: images)
          }
        imagePicker.delegate = imagePhotoPicker
          UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true)
      }) {
        Text("Fotoğraf Ekle")
          .foregroundColor(.white)
          .padding()
          .background(Color.blue)
          .cornerRadius(10)
      }
      .padding(.bottom)

      // Görüntü ızgarası için koşullu görünüm
      if showImageGrid {
        // LazyVGrid kullanarak görüntüleri bir ızgara düzeni içinde gösterin
        LazyVGrid(columns: [GridItem(.flexible())]) {
          ForEach(images.indices) { index in
            let image = images[index]
            Image(image)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 100, height: 100)
              .padding(.all, 5)
              .id(index) // Tanımlayıcı olarak dizini kullanın
          }
        }
      } else if error != nil {
        // Hata mesajı göster
        Text("Görüntü yüklenemedi: \(error!.localizedDescription)")
          .foregroundColor(.red)
      } else {
        Text("Henüz eklenmiş fotoğraf yok.")
          .foregroundColor(.gray)
      }

      Spacer()
    }
  }

  // Görüntüleri yüklemek için (seçilen görüntülerden veya placeholder'lar)
  func loadImages() {
    images.removeAll() // Seçilen görüntüleri temizle
    if !selectedImages.isEmpty {
      // Seçilen görüntüleri UI'a ekle
      images = selectedImages.map { Image(uiImage: $0) }
    } else {
      // Seçilmiş görüntü yoksa placeholder ekle
      images = [Image(systemName: "photo")] // Placeholder image
    }
    showImageGrid = true
  }
}

// Önizleme (gerçek verilerinizle veya test görüntü yükleme mantığınızla değiştirin)
struct LessonPictureView_Previews: PreviewProvider {
    static var previews: some View {
        LessonPictureView(lesson: Lesson(name: "Ders Adı", day: "Gün", startTime: "Başlangıç Saati", endTime: "Bitiş Saati", isActive: true, images: []))
    }
}
*/
