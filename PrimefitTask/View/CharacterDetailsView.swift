//
//  CharacterDetailsView.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import SwiftUI

struct CharacterDetailsView: View {
  let character: CharacterModel?
  
  var body: some View {
    if let character {
      CharacterFlipCard(character: character)
        .padding()
        .navigationTitle("Character Details")
        .navigationBarTitleDisplayMode(.inline)
    } else {
      Text("No character selected")
        .foregroundColor(.gray)
    }
  }
}



#Preview {
  CharacterDetailsView(
    character: CharacterModel(
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
  )
}
