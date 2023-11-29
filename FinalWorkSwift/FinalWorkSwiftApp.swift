//
//  FinalWorkSwiftApp.swift
//  FinalWorkSwift
//
//  Created by Lucas Robaert on 15/10/23.
//

import SwiftUI
import SwiftData

@main
struct FinalWorkSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Favorite.self])
    }
}
