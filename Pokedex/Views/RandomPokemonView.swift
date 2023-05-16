//
//  RandomPokemonView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI

import SwiftUI
import PokemonAPI

struct RandomPokemonView: View {
	@ObservedObject private(set) var viewModel: RandomPokemonViewModel

	@State private var isShowingCodeInputView = false
	@State private var isShowingSavedPokemonView = false
	@State private var code = ""

	var body: some View {
		VStack {
			if let pokemon = viewModel.pokemon {
				Text(pokemon.name?.capitalized ?? "No name")
					.font(.title)
				AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
					.frame(width: 150, height: 150)
				Text("Type: \(pokemon.types?.first?.type?.name?.capitalized ?? "")")
				
				if let evolutionChain = viewModel.evolutionChain {
					EvolutionChainView(viewModel: EvolutionChainViewModel(chain: evolutionChain))
				}

			} else {
				ProgressView()
			}

			Button("Parents") {
				self.isShowingCodeInputView = true
			}
			.padding(.top, 20)
			.sheet(isPresented: $isShowingCodeInputView) {
				ParentsView(onDismiss: {
					self.isShowingCodeInputView = false
				})
			}
		}
		.padding(.vertical, 5)
	}
}

struct RandomPokemonView_Previews: PreviewProvider {
	static var previews: some View {
		RandomPokemonView(viewModel: RandomPokemonViewModel(pokemon: PreviewData.Pokemon607))
	}
}
