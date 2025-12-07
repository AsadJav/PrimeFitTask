//
//  PhotosListViewModel.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import Foundation
import SwiftData

@MainActor
class CharactersListViewModel: ObservableObject {
  
  @Published var characters: [CharacterModel] = []
  @Published var errorMessage: String?
  @Published var isLoading: Bool = false
  @Published var isLoadingPage: Bool = false
  @Published var showPagingLoader: Bool = false
  
  private let networkManager: CharacterServiceProtocol
  private let dbManager: CharactersDBProtocol
  private var currentPage = 1
  private var hasNextPage = true
  private let maxPages = 5
  
  init(networkManager: CharacterServiceProtocol = NetworkManager.shared, dbManager: CharactersDBProtocol = DBManager.shared) {
    self.networkManager = networkManager
    self.dbManager = dbManager
  }
  
  func loadFirstPage() async {
    let saved = dbManager.loadCharacters()
    
    if !saved.isEmpty {
      self.characters = saved
      return
    }
    
    await resetAndLoad()
  }
  
  func resetAndLoad() async {
    currentPage = 1
    hasNextPage = true
    characters.removeAll()
    
    dbManager.clearCharacters()
    
    await loadCharacters()
  }
  
  func loadCharacters() async {
    guard hasNextPage else { return }
    guard currentPage <= maxPages else { return }
    guard !isLoadingPage else { return }
    
    isLoadingPage = true
    isLoading = currentPage == 1
    showPagingLoader = currentPage > 1
    
    do {
      try await Task.sleep(for: .seconds(2))
    } catch {
      print("Error: \(error.localizedDescription)")
    }
    
    do {
      let newData = try await networkManager.fetchCharacters(page: currentPage)
      
      if newData.isEmpty {
        hasNextPage = false
      } else {
        characters += newData
        dbManager.saveCharacters(newData)
        currentPage += 1
      }
      
    } catch {
      errorMessage = error.localizedDescription
      hasNextPage = false
    }
    
    isLoading = false
    isLoadingPage = false
    showPagingLoader = false
  }
}
