//
//  MockDBManager.swift
//  PrimefitTaskTests
//
//  Created by user on 07/12/2025.
//

import Foundation
@testable import PrimefitTask

final class MockDBManager: CharactersDBProtocol {

    var stored: [CharacterModel] = []

    func loadCharacters() -> [CharacterModel] {
        stored
    }

    func saveCharacters(_ characters: [CharacterModel]) {
        stored += characters
    }

    func clearCharacters() {
        stored.removeAll()
    }
}

