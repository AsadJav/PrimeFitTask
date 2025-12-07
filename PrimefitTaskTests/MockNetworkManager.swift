//
//  MockNetworkManager.swift
//  PrimefitTaskTests
//
//  Created by user on 07/12/2025.
//

import Foundation
@testable import PrimefitTask

final class MockNetworkManager: CharacterServiceProtocol {

    var pages: [[CharacterModel]] = []
    var shouldThrowError = false
    var errorToThrow: Error = APIError.networkFailure

    func fetchCharacters(page: Int) async throws -> [CharacterModel] {
        if shouldThrowError {
            throw errorToThrow
        }

        let index = max(0, page - 1)
        guard index < pages.count else { return [] }
        return pages[index]
    }
}

