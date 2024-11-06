import SwiftUI

struct LessonFileGroup: View {
    @State private var lessons = LessonAddManager.shared.fetchLessons()
    @State private var showHome = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
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
                }
                .padding()

                let uniqueLessonNames = Array(Set(lessons.map { $0.name })).sorted() 
                // Aynı ders isimlerini filtreler ve sıralar
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(uniqueLessonNames, id: \.self) { lessonName in
                        if let lesson = lessons.first(where: { $0.name == lessonName }) {
                            NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                                HStack {
                                    Image(systemName: "folder.fill")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: 60, maxHeight: 50)
                                    Spacer()
                                    Text(lesson.name)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(10)
                                    Spacer()
                                }
                                .frame(width: 350, height: 50)
                                .background(Color.init(hex: "#1c86ee"))
                                .cornerRadius(15)
                            }
                        }
                    }
                }

                Spacer()
            }
        }
    }
}

#Preview {
    LessonFileGroup()
}

