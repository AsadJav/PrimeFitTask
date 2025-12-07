//
//  NetworkManager.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import Foundation

protocol CharacterServiceProtocol {
  func fetchCharacters(page: Int) async throws -> [CharacterModel]
}

final class NetworkManager: CharacterServiceProtocol {
  static let shared = NetworkManager()
  
  private init() {}
  
  func fetchCharacters(page: Int) async throws -> [CharacterModel] {
    let urlString = "\(charactersApiUrl)/?page=\(page)"
    
    guard let url = URL(string: urlString) else {
      throw APIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let http = response as? HTTPURLResponse,
          (200...299).contains(http.statusCode) else {
      throw APIError.networkFailure
    }
    
    do {
      return try JSONDecoder().decode(CharacterResponse.self, from: data).results
    } catch {
      throw APIError.decodingFailure
    }
  }
}
