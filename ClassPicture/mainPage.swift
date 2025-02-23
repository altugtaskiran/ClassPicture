//
//  mainPage.swift
//  classChat
//
//  Created by Altuğ Taşkıran on 8.03.2024.
//

import SwiftUI

struct mainPage: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showAddSchedule = false
    @State var goLesson = false
    @State var showLessonFileGroup = false
    @State private var isFirstItemClicked = false
    @State private var showList = false
    @State var AccountViewShow = false
    @State private var modelList = ModelList // ModelList'i state özniteliği olarak tanımlamak gerekli.
    @StateObject private var cameraManager = CameraManager()
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
        
        if goLesson {
            LessonSchedule()
                .fullScreenCover(isPresented:$goLesson){
                    LessonSchedule()
                }
        }
        if showAddSchedule {
            LessonAddSchedule().fullScreenCover(isPresented:$showAddSchedule){
                LessonAddSchedule()
            }
        }
        if showLessonFileGroup {
            LessonFileGroup()
                .fullScreenCover(isPresented: $showLessonFileGroup){
                    LessonFileGroup()
                }
        }
        
        
        VStack {
            
            HStack {
                Image(systemName: "person")
                    .font(.title)
                    .foregroundColor(.black)
                    .onTapGesture {
                        AccountViewShow.toggle()}
                    .fullScreenCover(isPresented:$AccountViewShow){
                        AccountView()
                    }
                
                Spacer()
                VStack {
                }
                Image(systemName: "gearshape")
                    .foregroundColor(.black)
                    .font(.title)
                
            }.padding()
                .foregroundColor(colorScheme == .dark ? .black : .white) 
            // Koyu modda renk değişimini devre dışı 
            
            ZStack {
                ForEach(ModelList.indices, id: \.self) { index in
                    HStack {
                        ModelListView(showList: self.$showList,
                                      icon: ModelList[index].icon,
                                      name: ModelList[index].name,
                                      arrowIcon: index == 0 ? self.showList ? .down : .firstArrow : .right)
                        .foregroundStyle(.white)
                        .font(.system(size: 17))
                        
                    }//hstack sonu
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#ff7f00")
                        .opacity(showList ? 1 : (1-Double(index) * 0.3)),
                                in: RoundedRectangle(cornerRadius: 15))
                    .offset(y: CGFloat(index) * (showList ? 58 : 7))
                    .onTapGesture {
                        withAnimation {
                            if index == 0 {   //index 0 tıklandığında aç sadece
                                self.showList.toggle()
                                self.isFirstItemClicked.toggle()
                            } else if index == 1 {
                                goLesson.toggle()
                            } else if index == 2 {
                                showAddSchedule.toggle()
                            } else if index == 3 {
                                showLessonFileGroup.toggle()
                            }
                        }
                    }.zIndex(CGFloat(index * -1))
                        .padding(.top, 40)
                    
                }
                .padding(.horizontal)
            }   //zstack
            
        }.background(Color.white)
        // Ders saati gelince gösteren kısım
        Spacer()
        LessonTime()
            .offset(y: -80)
            .onAppear {
                if getTodayLesson().first(where: isLessonTime) != nil {
                    cameraManager.startCamera()
                }
            }
            .sheet(isPresented: $cameraManager.isCameraPresented) {
                CameraView(cameraManager: cameraManager)
                    .onDisappear {
                        if let image = cameraManager.image, let activeLesson = getTodayLesson().first(where: isLessonTime) {
                            saveImage(image, for: activeLesson)
                        }
                    }
            }
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
    
    func getTodayLesson() -> [Lesson] {
        let allLessons = LessonAddManager.shared.fetchLessons()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let today = formatter.string(from: Date())
        return allLessons.filter { $0.day == today }
    }
    
    func saveImage(_ image: UIImage, for lesson: Lesson) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try data.write(to: url)
            var updatedLesson = lesson
            updatedLesson.images.append(filename)
            LessonAddManager.shared.updateLesson(updatedLesson)
        } catch {
            print("Unable to save image to disk: \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

#Preview {
    mainPage()
}
