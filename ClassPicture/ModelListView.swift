//
//  ModelListView.swift
//  LessonPic
//
//  Created by Altuğ Taşkıran on 8.03.2024.
//

import SwiftUI

struct ModelListView: View {
    
    @Binding var showList: Bool
    
    let icon: String
    let name: String
    let arrowIcon: ArrowIcon
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .offset(x: 5)
            Text(name)
                .offset(x: 10)
            Spacer()
            Image(systemName: arrowIcon.rawValue)
                .offset(x: -5)
        }
    }
}

extension ModelListView {
    enum ArrowIcon: String {
        case firstArrow = "chevron.forward"
        case up = "arrow.up"
        case right = "arrow.right"
        case down = "arrow.down"
        
    }
}



