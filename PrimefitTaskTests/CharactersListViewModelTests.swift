//
//  CharactersListViewModelTests.swift
//  PrimefitTaskTests
//
//  Created by user on 07/12/2025.
//

import XCTest
@testable import PrimefitTask

@MainActor
final class CharactersListViewModelTests: XCTestCase {
  
  var viewModel: CharactersListViewModel!
  var mockNetwork: MockNetworkManager!
  var mockDB: MockDBManager!

  override func setUp() {
      mockNetwork = MockNetworkManager()
      mockDB = MockDBManager()
      viewModel = CharactersListViewModel(networkManager: mockNetwork, dbManager: mockDB)
  }

  override func tearDown() {
      viewModel = nil
      mockNetwork = nil
      mockDB = nil
  }
  

  // MARK: - Test first page success
  func test_loadCharacters() async {
      mockNetwork.pages = [[
        CharacterModel(
          id: 1,
          name: "Rick Sanchez",
          status: "Alive",
          species: "Human",
          type: "",
          gender: "Male",
          origin: Location(name: "Earth", url: "https://rick.com"),
          location: Location(name: "Citadel of Ricks", url: "https://citadel.com"),
          image: "https://rick-image.com",
          url: "https://api.com/character/1",
          created: "2025-01-01"
        )
      ]]

      await viewModel.loadCharacters()

      XCTAssertEqual(viewModel.characters.count, 1)
      XCTAssertFalse(viewModel.isLoading)
      XCTAssertFalse(viewModel.isLoadingPage)
      XCTAssertFalse(viewModel.showPagingLoader)
  }

}
