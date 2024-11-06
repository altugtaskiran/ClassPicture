//
//  LessonSchedule.swift
//  classChat
//
//  Created by Altuğ Taşkıran on 9.03.2024.
//

import SwiftUI

struct Lesson: Identifiable,Codable, Hashable {
    var id = UUID()
    var name: String
    var day: String
    var startTime: String
    var endTime: String
    var isActive: Bool
    var images: [String]
}



struct LessonAddSchedule: View {
    
    @State var saveClicked = false
    @State private var selectedDayIndex = 0
    @State private var lessonTime = ""
    @State private var currentTime = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var showHome = false
    @State private var lessonName = ""
    @State private var showLessonPicture = false
    
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var todayLessons: [Lesson] {
        getTodayLesson()}
    
    var body: some View {
        
        
        if saveClicked {
            LessonScheduleMainView()
                .fullScreenCover(isPresented:$saveClicked){
                    LessonScheduleMainView()
                }
        }
        
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
            }.padding()
            
            
            
            
            VStack {
                Text("Lesson Name")
                    .font(.headline)
                    .foregroundColor(.black)
                TextField("Lesson Name", text: $lessonName)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .foregroundColor(.black)
                
                
                
                HStack{
                    Text("Day:")
                        .foregroundColor(.black)
                        .font(.headline)
                    Picker("Day", selection: $selectedDayIndex) {
                        ForEach(daysOfWeek.indices, id: \.self, content: { index in
                            Text(self.daysOfWeek[index])
                        }
                        )}.pickerStyle(MenuPickerStyle())
                        .foregroundColor(.black)
                    
                    
                }
                
                
                DatePicker("Start Time: ", selection: $startTime, displayedComponents: .hourAndMinute).font(.headline)
                    .foregroundColor(.black)
                
                
                
                //TextField("Hour", text: $startTime)
                //  .multilineTextAlignment(.center)
                //.frame(height: 50)
                
                
                DatePicker("End Time: ", selection: $endTime, displayedComponents: .hourAndMinute).font(.headline)
                    .foregroundColor(.black)
                
                HStack{
                    Button("Save"){
                        saveLesson()
                        saveClicked.toggle()
                    }.bold()
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color(hex: "#1e90ff"))
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal).padding(.top, 80)
            
            
            Spacer()
        }.background(Color.white)
    }
    
    func timeFormat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func isLessonTime(_ lesson: Lesson) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTimeString = formatter.string(from: currentTime)
        
        return currentTimeString >= lesson.startTime && currentTimeString <= lesson.endTime
    }
    
    func getTodayLesson() -> [Lesson]{
        
        let allLessons = LessonAddManager.shared.fetchLessons()
        let formatter = DateFormatter()
        formatter.dateFormat =  "EEEE"
        let today = formatter.string(from: Date())
        return allLessons.filter {$0.day == today}
    }
    
    func saveLesson() {
        _ = daysOfWeek[selectedDayIndex]
        let lesson = Lesson(name: lessonName, day: daysOfWeek[selectedDayIndex], startTime: timeFormat(startTime), endTime: timeFormat(endTime), isActive: false, images: ["images"])
        LessonAddManager.shared.saveLesson(lesson)
        
        
    }
    
}

#Preview {
    LessonAddSchedule()
}


