//
//  FlipCard.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//


import SwiftUI

struct FlipCard<Front: View, Back: View>: View {
  @State private var flipped = false
  @State private var rotationAngle: Double = 0
  
  let front: Front
  let back: Back
  
  var body: some View {
    ZStack {
      front
        .opacity(flipped ? 0 : 1)
        .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
      
      back
        .opacity(flipped ? 1 : 0)
        .rotation3DEffect(.degrees(rotationAngle + 180), axis: (x: 0, y: 1, z: 0))
    }
    .frame(height: 300)
    .onTapGesture {
      flipCard()
    }
    .animation(.spring(duration: 0.6), value: rotationAngle)
  }
  
  private func flipCard() {
    flipped.toggle()
    if flipped {
      rotationAngle = 180
    } else {
      rotationAngle = 0
    }
  }
}
