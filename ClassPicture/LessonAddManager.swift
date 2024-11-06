//
//  LessonAddManager.swift
//  ClassPicture
//
//  Created by Altuğ Taşkıran on 11.06.2024.
//
import Foundation

class LessonAddManager {
    static let shared = LessonAddManager()
    private let key = "lessons"

    func saveLesson(_ lesson: Lesson) {
        var lessons = fetchLessons()
        lessons.append(lesson)

        saveLessons(lessons)
    }

    func fetchLessons() -> [Lesson] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: key),
           let lessons = try? decoder.decode([Lesson].self, from: data) {
            return lessons
        }
        return []
    }

    func updateLesson(_ updatedLesson: Lesson) {
        var lessons = fetchLessons()
        if let index = lessons.firstIndex(where: { $0.id == updatedLesson.id }) {
            lessons[index] = updatedLesson
            saveLessons(lessons)
        }
    }

    func deleteLesson(_ lesson: Lesson) {
        var lessons = fetchLessons()
        if let index = lessons.firstIndex(where: { $0.id == lesson.id }) {
            lessons.remove(at: index)
            saveLessons(lessons)
        }
    }

    private func saveLessons(_ lessons: [Lesson]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(lessons) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}


/* class LessonAddManager {
    static let shared = LessonAddManager()
    private let key = "lessons"
    
    
    func saveLesson(_ lesson: Lesson) {
        var lessons = fetchLessons()
        lessons.append(lesson)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(lessons) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func fetchLessons() -> [Lesson] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: key),
           let lessons = try? decoder.decode([Lesson].self, from: data) {
            return lessons
        }
        return []
    }
    
    func deleteLesson(_ lesson: Lesson) {
        var lessons = fetchLessons()
        if let index = lessons.firstIndex(where: { $0.id == lesson.id }) {
            lessons.remove(at: index)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(lessons) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
*/
