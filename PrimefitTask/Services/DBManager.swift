//
//  DBManager.swift
//  PrimefitTask
//
//  Created by user on 06/12/2025.
//

import Foundation
import SwiftData

protocol CharactersDBProtocol {
  func loadCharacters() -> [CharacterModel]
  func saveCharacters(_ characters: [CharacterModel])
  func clearCharacters()
}

final class DBManager: CharactersDBProtocol {
  
  static let shared = DBManager()
  
  var context: ModelContext!
  
  private init() {}
  
  func loadCharacters() -> [CharacterModel] {
    let fetch = FetchDescriptor<CharacterModel>()
    return (try? context.fetch(fetch)) ?? []
  }
  
  func saveCharacters(_ characters: [CharacterModel]) {
    for c in characters {
      context.insert(c)
    }
    try? context.save()
  }
  
  func clearCharacters() {
    try? context.delete(model: CharacterModel.self)
  }
  
  
}
