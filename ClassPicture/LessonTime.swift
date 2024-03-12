//
//  LessonTime.swift
//  classChat
//
//  Created by Altuğ Taşkıran on 11.03.2024.
//

import SwiftUI
import UIKit

struct LessonTime: View {
    @State private var currentTime = Date()
    
    var sortedLessons: [Lesson] {
        getTodayLesson().sorted { lesson1, lesson2 in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            if let date1 = formatter.date(from: lesson1.startTime), let date2 = formatter.date(from: lesson2.startTime) {
                return date1 < date2
            } else {
                return false
            }
        }
    }
    
    var body: some View {
        
        Text("Today's Lessons").foregroundColor(Color(hex: "#6a5acd"))
            .multilineTextAlignment(.center)
            .font(.title)
            .bold()
            .foregroundColor(.black)
            .padding(.top, 70)
            .padding(20)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                    ForEach(sortedLessons, id: \.self) { lesson in
                        VStack {
                            Text("\(lesson.name)")
                            Text("\(lesson.day)")
                            Text("\(lesson.startTime) - \(lesson.endTime)")
                        }.fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .padding()
                            .background(isLessonTime(lesson) ? Color.init(hex: "#00cc00") : Color.clear)
                            .background(Color.init(hex: "1e90ff"))
                            .cornerRadius(15)
                    }
                }
            }//scrolView
            .padding(.horizontal)
        }
    

    func timeFormat(date: Date) -> String {
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
    
}

#Preview {
    LessonTime()
}

