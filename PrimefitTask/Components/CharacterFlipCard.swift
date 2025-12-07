//
//  CharacterFlipCard.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import SwiftUI
import NukeUI

struct CharacterFlipCard: View {
  let character: CharacterModel
  let dateFormatter = DateFormatter()
  
  var body: some View {
    FlipCard(
      front: frontCard,
      back: backCard
    )
    .padding()
  }
}

extension CharacterFlipCard {
  var frontCard: some View {
    ZStack {
      LazyImage(url: URL(string: character.image)) { state in
        if let image = state.image {
          image
            .resizable()
            .scaledToFill()
        } else if state.error != nil {
          Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .padding()
        } else {
          ProgressView()
        }
      }
    }
    .frame(width:350, height: 500)
    .clipped()
    .cornerRadius(20)
    .shadow(radius: 8)
  }
  
  
  var backCard: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(character.name)
        .font(.title)
        .bold()
      
      Text("Status: \(character.status)")
      Text("Species: \(character.species)")
      Text("Gender: \(character.gender)")
      Text("Location: \(character.location.name)")
      Text("Url: \(character.location.url)")
      
      Spacer()
    }
    .padding()
    .frame(width:350, height: 500)
    .background(.white)
    .cornerRadius(20)
    .shadow(radius: 8)
  }
}
