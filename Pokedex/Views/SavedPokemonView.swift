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
	
	@Binding var pokemon: PKMPokemon? {
		didSet {
			viewModel.currentPokemon = pokemon
		}
	}
	
	let onDismiss: () -> Void
	
	var body: some View {
		VStack {
			Text("Saved Pokémon")
				.font(.title)
				.padding(.bottom, 20)
			
			List(viewModel.savedPokemons) { pokemon in
				Text(pokemon.name)
			}
			
			Button("Save Current Pokémon") {
				viewModel.saveCurrentPokemon()
			}
			.foregroundColor(.blue)
			.font(.title2)
			.padding(.vertical, 10)
			
			Button("New Random Pokémon") {
				signals.askRandomPokemon = true
				onDismiss()
			}
			.foregroundColor(.blue)
			.font(.title2)
			.padding(.vertical, 10)

			Spacer()
			
			Button("Close") {
				onDismiss()
			}
			.foregroundColor(.blue)
			.font(.title2)
		}
		.padding()
		.background(Color.white)
		.cornerRadius(10)
		.shadow(radius: 10)
	}
}

struct SavedPokemonView_Previews: PreviewProvider {
	static var previews: some View {
		@State var pokemon: PKMPokemon? = nil
		SavedPokemonView(pokemon: $pokemon, onDismiss: {})
	}
}
