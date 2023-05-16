//
//  RandomPokemonView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI
import PokemonAPI

struct RandomPokemonView: View {
	@ObservedObject private(set) var viewModel: RandomPokemonViewModel
	@StateObject private var signals = Signals()

	@State private var isShowingCodeInputView = false
	@State private var isShowingSavedPokemonView = false
	@State private var code = ""
	
	var body: some View {
		VStack {
			if let pokemon = viewModel.currentPokemon {
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
				ParentsView(pokemon: $viewModel.currentPokemon, onDismiss: {
					self.isShowingCodeInputView = false
				})
			}
		}
		.padding(.vertical, 5)
		.environmentObject(signals)
		.onChange(of: signals.changePokemon) { newValue in
			if newValue {
				switch signals.pokemonType {
				case .random:
					viewModel.fetchRandomPokemon()
					signals.changePokemon = false
				case .exact(let id):
					viewModel.fetchExactPokemon(id: id)
					signals.changePokemon = false
				case .none:
					print("none")
				}
			}
		}
	}
}

struct RandomPokemonView_Previews: PreviewProvider {
	static var previews: some View {
		RandomPokemonView(viewModel: RandomPokemonViewModel(pokemon: PreviewData.Pokemon607))
	}
}
