//
//  TableModel.swift
//  classChat
//
//  Created by Altuğ Taşkıran on 8.03.2024.
//

import Foundation
// TODO:
// e'den sonra boşluk bırak.
// Identifiable {

struct Model: Identifiable {
    var id = UUID()
    let icon: String
    let name: String
}

// variable isimleri küçük harfle başlar
let ModelList = [
    Model(icon: "ellipsis.rectangle", name:"More"),
    Model(icon: "books.vertical", name:"Lesson Schedule"),
    Model(icon: "books.vertical.circle", name: "Add Lesson"),
    Model(icon: "folder.fill", name:"Lesson Pictures"),
    

]


