import SwiftUI


struct LessonSchedule: View {
    @State var showHome = false
    @State private var lessons = LessonAddManager.shared.fetchLessons()
    @State private var selectedDayIndex = 0
    
    var daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    
    var body: some View {
        
        
        VStack {
            HStack{
                Image(systemName: "arrow.uturn.backward")
                    .foregroundColor(.black)
                    .onTapGesture {
                        showHome.toggle()}
                    .fullScreenCover(isPresented:$showHome){
                        ContentView()
                    }
                    .offset(x: 5)
                
                Spacer()
            }.padding()
            
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<daysOfWeek.count, id: \.self) { index in
                        Button(action: {
                            self.selectedDayIndex = index
                        }) {
                            Text(daysOfWeek[index])
                                .foregroundColor(self.selectedDayIndex == index ? .black : .gray)
                                .padding()
                                .background(self.selectedDayIndex == index ? Color.blue : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                }
            }.padding()
            
            
            
            
            
            
            
            
            List {
                ForEach(filteredLessons(), id: \.id) { lesson in
                    VStack(alignment: .leading) {
                        Text(lesson.name)
                            .font(.headline)
                            .foregroundColor(Color.black)
                        Text("Day: \(lesson.day)")
                            .foregroundColor(Color.black)
                        Text("Time: \(lesson.startTime) - \(lesson.endTime)")
                            .foregroundColor(Color.black)
                    }
                }
                .onDelete { indexSet in // delete to swipe
                    for index in indexSet {
                        let lessonToDelete = lessons[index]
                        LessonAddManager.shared.deleteLesson(lessonToDelete)
                    }
                    lessons = LessonAddManager.shared.fetchLessons()
                }
            }
            
        }.background(Color.white)
        
    }
    
    func filteredLessons() -> [Lesson] {
        return lessons.filter { $0.day == daysOfWeek[selectedDayIndex] }
    }
}



#Preview {
    LessonSchedule()
}



