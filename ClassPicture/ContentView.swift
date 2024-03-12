//
//  ContentView.swift
//  classChat
//
//  Created by Altuğ Taşkıran on 8.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isFirstItemClicked = false
    @State private var showList = false
    @State var AccountViewShow = false
    @State private var modelList = ModelList // modellisti state özniteliği olarak tanımladık
    
    var body: some View {

        VStack{
        mainPage()
        }.background(Color.white)
    }
}

#Preview {
    ContentView()
}

