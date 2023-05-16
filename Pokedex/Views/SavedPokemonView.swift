//
//  SavedPokemonView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI

struct SavedPokemonView: View {
	@StateObject private var viewModel = SavedPokemonViewModel()
	
	let onDismiss: () -> Void
	
	var body: some View {
		VStack {
			Text("Saved Pokémon")
				.font(.title)
				.padding(.bottom, 20)
			
			Button("Save Current Pokémon") {
				viewModel.saveCurrentPokemon()
			}
			.foregroundColor(.blue)
			.font(.title)
			.padding(.vertical, 10)
			
			Button("New Random Pokémon") {
				viewModel.openNewRandomPokemon()
			}
			.foregroundColor(.blue)
			.font(.title)
			.padding(.vertical, 10)
			
			Spacer()
			
			Button("Close") {
				onDismiss()
			}
			.foregroundColor(.blue)
			.font(.title)
		}
		.padding()
		.background(Color.white)
		.cornerRadius(10)
		.shadow(radius: 10)
	}
}

struct SavedPokemonView_Previews: PreviewProvider {
	static var previews: some View {
		SavedPokemonView(onDismiss: {})
	}
}
