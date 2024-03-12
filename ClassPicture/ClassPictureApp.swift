//
//  ClassPictureApp.swift
//  ClassPicture
//
//  Created by Altuğ Taşkıran on 12.03.2024.
//

import SwiftUI

@main
struct ClassPictureApp: App {
    @Environment(\.colorScheme) var colorScheme

    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.light)
        }
    }
}
