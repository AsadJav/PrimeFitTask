//
//  CharacterModel.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import Foundation
import SwiftData

// MARK: - CharacterResponse
struct CharacterResponse: Codable {
  let results: [CharacterModel]
}

// MARK: - CharacterModel
@Model
class CharacterModel: Identifiable, Codable {
  @Attribute(.unique) var id: Int
  var name: String
  var status: String
  var species: String
  var type: String
  var gender: String
  var origin: Location
  var location: Location
  var image: String
  var url: String
  var created: String
  
  // MARK: - Manual initializer (for previews)
  init(
    id: Int,
    name: String,
    status: String,
    species: String,
    type: String,
    gender: String,
    origin: Location,
    location: Location,
    image: String,
    url: String,
    created: String
  ) {
    self.id = id
    self.name = name
    self.status = status
    self.species = species
    self.type = type
    self.gender = gender
    self.origin = origin
    self.location = location
    self.image = image
    self.url = url
    self.created = created
  }
  
  enum CodingKeys: String, CodingKey {
    case id, name, status, species, type, gender, origin, location, image, url, created
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    status = try container.decode(String.self, forKey: .status)
    species = try container.decode(String.self, forKey: .species)
    type = try container.decode(String.self, forKey: .type)
    gender = try container.decode(String.self, forKey: .gender)
    origin = try container.decode(Location.self, forKey: .origin)
    location = try container.decode(Location.self, forKey: .location)
    image = try container.decode(String.self, forKey: .image)
    url = try container.decode(String.self, forKey: .url)
    created = try container.decode(String.self, forKey: .created)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(status, forKey: .status)
    try container.encode(species, forKey: .species)
    try container.encode(type, forKey: .type)
    try container.encode(gender, forKey: .gender)
    try container.encode(origin, forKey: .origin)
    try container.encode(location, forKey: .location)
    try container.encode(image, forKey: .image)
    try container.encode(url, forKey: .url)
    try container.encode(created, forKey: .created)
  }
}

// MARK: - Location
struct Location: Codable {
  let name: String
  let url: String
}
