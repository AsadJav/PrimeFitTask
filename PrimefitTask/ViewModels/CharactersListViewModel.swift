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
  
  private let repository: CharacterServiceProtocol
  private let dbManager: DBManager
  private var currentPage = 1
  private var hasNextPage = true
  private let maxPages = 5
  
//  init(networkManager: NetworkManager = .shared, dbManager: DBManager = .shared) {
//    self.networkManager = networkManager
//    self.dbManager = dbManager
//  }
  
  init(repository: CharacterServiceProtocol = CharacterRepository(), dbManager: DBManager = .shared) {
    self.repository = repository
    self.dbManager = dbManager
  }
  
  // MARK: - LOAD FROM DATABASE FIRST
  func loadFirstPage() async {
    let saved = dbManager.loadCharacters()
    
    if !saved.isEmpty {
      self.characters = saved
      return
    }
    
    await resetAndLoad()
  }
  
  // MARK: - RESET (Refresh)
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
      let newData = try await repository.fetchCharacters(page: currentPage)
      
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
