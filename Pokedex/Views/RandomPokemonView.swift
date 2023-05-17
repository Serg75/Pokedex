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
	@State private var code = ""
	
	var body: some View {
		ZStack {
			VStack {
				if let pokemon = viewModel.currentPokemon {
					Text("Pokémon of the day")
						.font(.title)
					VStack {
						AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
							.frame(width: 100, height: 100)
						
						Text(pokemon.name?.capitalized ?? "No name")
							.font(.title2)
					}
					.padding(.bottom)
					.frame(minWidth: 200)
					.background(Color(.systemOrange).opacity(0.4))
					.clipShape(RoundedRectangle(cornerRadius: 10))
					
					if let evolutionChain = viewModel.evolutionChain {
						
						Text("Evolution:")
							.font(.title2)
							.bold()
							.padding(.bottom, -10)
							.padding(.top, 20)
						
						EvolutionChainView(viewModel: EvolutionChainViewModel(chain: evolutionChain))
					}
					
					Spacer()
					
				} else {
					ProgressView()
				}
			}
			ParentButton(viewModel: viewModel, isShowingCodeInputView: $isShowingCodeInputView)
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

struct ParentButton: View {
	@ObservedObject var viewModel: RandomPokemonViewModel
	@Binding var isShowingCodeInputView: Bool
	
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				Button(action: {
					self.isShowingCodeInputView = true
				}) {
					Image(systemName: "person.2.circle")
						.resizable()
						.frame(width: 30, height: 30)
				}
				.padding(.trailing, 20)
				.sheet(isPresented: $isShowingCodeInputView) {
					ParentsView(pokemon: $viewModel.currentPokemon, onDismiss: {
						self.isShowingCodeInputView = false
					})
				}
			}
		}
	}
}
