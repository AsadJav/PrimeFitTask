//
//  APIError.swift
//  PrimefitTask
//
//  Created by user on 06/12/2025.
//


import Foundation

enum APIError: LocalizedError {
  case invalidURL
  case networkFailure
  case decodingFailure
  case unexpectedStatusCode(Int)
  case noInternet
  case unknown
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "The URL is invalid."
    case .networkFailure:
      return "A network error occurred."
    case .decodingFailure:
      return "Failed to decode server response."
    case .unexpectedStatusCode(let code):
      return "Unexpected status code: \(code)"
    case .noInternet:
      return "No internet connection."
    case .unknown:
      return "An unknown error occurred."
    }
  }
}
