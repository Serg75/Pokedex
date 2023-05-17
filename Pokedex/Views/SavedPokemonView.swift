//
//  SavedPokemonView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI
import PokemonAPI

struct SavedPokemonView: View {
	@StateObject private var viewModel = SavedPokemonViewModel()
	@EnvironmentObject private var signals: Signals
	
	@State private var selectedPokemon: Int? = nil
	
	private var pokemon: PKMPokemon?
	
	init(pokemon: PKMPokemon?, onDismiss: @escaping () -> Void) {
		self.pokemon = pokemon
		self.onDismiss = onDismiss
	}
	
	private let onDismiss: () -> Void
	
	var body: some View {
		VStack {
			Text("Saved Pokémons")
				.font(.title)
				.padding(.bottom, 20)
			
			List(viewModel.savedPokemons, selection: $selectedPokemon) { pokemon in
				Text(pokemon.name)
			}
			
			Button("Save Current Pokémon") {
				viewModel.saveCurrentPokemon()
			}
			.font(.title2)
			.padding(.vertical, 10)
			
			Button("Take selected Pokémon") {
				signals.pokemonType = .exact(selectedPokemon!)
				signals.changePokemon = true
				onDismiss()
			}
			.disabled(selectedPokemon == nil)
			.font(.title2)
			.padding(.vertical, 10)
			
			Button("New Random Pokémon") {
				signals.pokemonType = .random
				signals.changePokemon = true
				onDismiss()
			}
			.font(.title2)
			.padding(.vertical, 10)

			Spacer()
			
			Button("Close") {
				onDismiss()
			}
			.font(.title2)
		}
		.padding()
		.background(Color(.systemGray5))
		.cornerRadius(10)
		.shadow(radius: 10)
		.onAppear() {
			viewModel.currentPokemon = pokemon
		}
	}
}

struct SavedPokemonView_Previews: PreviewProvider {
	static var previews: some View {
		@State var pokemon: PKMPokemon? = nil
		SavedPokemonView(pokemon: nil, onDismiss: {})
	}
}
