//
//  PhotosListView.swift
//  PrimefitTask
//
//  Created by user on 05/12/2025.
//

import SwiftUI
import NukeUI
import SwiftData

struct CharactersListView: View {
  @Environment(\.modelContext) private var context
  @StateObject private var viewModel: CharactersListViewModel = CharactersListViewModel()
  @State private var selectedCharacter: CharacterModel? = nil
  @State private var showDetail: Bool = false
  
  var body: some View {
    ZStack {
      contentView
      
      if viewModel.isLoading {
        ProgressView("Loading...")
          .padding()
          .background(.ultraThinMaterial)
          .cornerRadius(12)
      }
    }
    .navigationTitle("Characters")
    .task {
      DBManager.shared.context = context
      await viewModel.loadFirstPage()
    }
    .refreshable {
      await viewModel.resetAndLoad()
    }
  }
}

private extension CharactersListView {
  @ViewBuilder
  var contentView: some View {
    if let error = viewModel.errorMessage {
      errorView(error)
    } else if viewModel.characters.isEmpty {
      emptyStateView
    } else {
      listView
    }
  }
  
  var listView: some View {
    ScrollView {
      LazyVStack(spacing: 12) {
        ForEach(viewModel.characters) { character in
          CharacterView(character: character)
            .onAppear {
              if character == viewModel.characters.last {
                Task {
                  await viewModel.loadCharacters()
                }
              }
            }
            .onTapGesture {
              selectedCharacter = character
              showDetail = true
            }
        }
        if viewModel.showPagingLoader {
          ProgressView()
            .padding()
        }
      }
      .padding(.vertical)
    }
    .navigationDestination(isPresented: $showDetail) {
      if let selectedCharacter {
        CharacterDetailsView(character: selectedCharacter)
      }
    }
  }
  
  func errorView(_ error: String) -> some View {
    VStack(spacing: 12) {
      Text(error)
        .foregroundColor(.red)
      Button("Retry") {
        Task { await viewModel.resetAndLoad() }
      }
    }
  }
  
  var emptyStateView: some View {
    VStack(spacing: 12) {
      Text("No data yet.")
        .foregroundColor(.gray)
    }
  }
}

#Preview {
  CharactersListView()
}


struct CharacterView: View {
  let character: CharacterModel
  var body: some View {
    VStack(alignment: .center){
      
      LazyImage(url: URL(string: character.image)) { state in
        if let image = state.image {
          image
            .resizable()
            .scaledToFill()
        } else if state.error != nil {
          Image(systemName: "photo")
        } else {
          ProgressView()
        }
      }
      .frame(width: 80, height: 80)
      .cornerRadius(10)
      
      
      Text("\(character.name)")
        .font(.caption)
        .bold()
    }
    .frame(maxWidth: .infinity)
  }
}
