//
//  PrimefitTaskApp.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import SwiftUI
import SwiftData

@main
struct PrimefitTaskApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            CharactersListView()
              .modelContainer(for: [CharacterModel.self])
          }
        }
    }
}
