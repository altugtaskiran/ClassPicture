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
    @State private var isFirstItemClicked = false
    @State private var showList = false
    @State var AccountViewShow = false
    @State private var modelList = ModelList // modellisti state özniteliği olarak tanımladık
    
    
   
    
    var body: some View {
        
        if goLesson {
            LessonSchedule()
                .fullScreenCover(isPresented:$goLesson){
                    LessonSchedule()
                }
            //for open full screen
        }
        if showAddSchedule {
            LessonAddSchedule().fullScreenCover(isPresented:$showAddSchedule){
                LessonAddSchedule()
            }
        }
        VStack{
            VStack {
                HStack{
                    Image(systemName: "person")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            AccountViewShow.toggle()}
                        .fullScreenCover(isPresented:$AccountViewShow){
                            AccountView()
                        }
                    Text("Account").foregroundColor(.black)
                        .frame(width: 80)
                        .onTapGesture {
                            AccountViewShow.toggle()}
                        .fullScreenCover(isPresented:$AccountViewShow){
                            AccountView()
                        }
                    Spacer()
                    VStack{
                        Text("Settings")
                            .foregroundColor(.black)
                    }
                    Image(systemName: "gearshape")
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                        .font(.title)
                    
                }.padding(10)
                    .foregroundColor(colorScheme == .dark ? .black : .white) // Koyu modda renk değişimini devre dışı bırakır
                
                
            }
            ZStack {
                ForEach(ModelList.indices, id: \.self) { index in
                    HStack {
                        ModelListView(showList: self.$showList,
                                      icon: ModelList[index].icon,
                                      name: ModelList[index].name,
                                      arrowIcon: index == 0 ? self.showList ? .down : .firstArrow : .right)
                        .foregroundStyle(.white)
                        .font(.system(size: 17))
                        
                    }//hstack
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#ff7f00")
                        .opacity(showList ? 1 : (1-Double(index) * 0.3)),
                                in: RoundedRectangle(cornerRadius: 15))
                    .offset(y: CGFloat(index) * (showList ? 58 : 7))
                    .onTapGesture {
                        withAnimation{
                            if index == 0 {   //index 0 tıklandığı aç sadece
                                self.showList.toggle()
                                self.isFirstItemClicked.toggle()
                            } else if index == 1 {
                                goLesson.toggle()
                            } else if index == 2 {
                                showAddSchedule.toggle()
                            }
                        }
                    }.zIndex(CGFloat(index * -1))
                        .padding(.top, 40)
                    
                }   //forEach index close
                .padding(.horizontal)
            }   //zstack
            
            
                 
        }.background(Color.white)
        //ders saati gelince gösteren kısım
        Spacer()
        LessonTime().offset(y: -80)
    }
        
}


#Preview {
    mainPage()
}

