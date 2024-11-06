//
//  AccountView.swift
//  classChat
//
//  Created by Altuğ Taşkıran on 8.03.2024.
//

import SwiftUI

struct AccountView: View {
    @State var AccountViewShow = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .offset(x: 5)
                    .foregroundColor(.black)
                    .onTapGesture {
                        AccountViewShow.toggle()}
                    .fullScreenCover(isPresented:$AccountViewShow){
                        ContentView()
                    }
               
                Spacer()

                    
            }.padding()
            
            VStack{
                Text("mail")
                Text("şifre")
                Text("şifre")
                
            }.padding(.top, 50)
                .foregroundColor(.black)
            
            Spacer()
        }.background(Color.white)
    }
    
}

#Preview {
    AccountView()
}

