import SwiftUI

struct LessonScheduleMainView: View {
    @State private var lessons = LessonAddManager.shared.fetchLessons()
    @State var addLessonSchedule = false
    @State var saveClicked = false
    @State var showHome = false

    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .onTapGesture {
                        showHome.toggle()}
                    .fullScreenCover(isPresented:$showHome){
                        ContentView()
                    }
                    .offset(x: 5)
                
                Spacer()
                
                Text("Add Lesson")
                    .frame(width: 100, height: 50)
                    .foregroundColor(.black)
                    .onTapGesture {
                        addLessonSchedule.toggle()}
                    .fullScreenCover(isPresented:$addLessonSchedule){
                        LessonAddSchedule()
                    }
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .background(Color.white)
                    .clipShape(Circle())
                    .font(.title)
                    .onTapGesture {
                        addLessonSchedule.toggle()}
                    .fullScreenCover(isPresented:$addLessonSchedule){
                        LessonAddSchedule()
                    }
                
            }.padding()
            
            VStack {
                List(lessons, id: \.id) { lesson in
                    VStack(alignment: .leading) {
                        Text(lesson.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text("Day: \(lesson.day)").foregroundColor(.black)
                        Text("Time: \(lesson.startTime) - \(lesson.endTime)").foregroundColor(.black)
                    }
                    Button("Delete", action: {
                        LessonAddManager.shared.deleteLesson(lesson)
                        lessons = LessonAddManager.shared.fetchLessons()
                    }).foregroundColor(.blue)
                }
            }
            
        }.background(Color.white)
    }
    }

#Preview {
    LessonScheduleMainView()
}

