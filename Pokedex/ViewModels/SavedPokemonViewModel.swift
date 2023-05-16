//
//  SavedPokemonViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI
import PokemonAPI

@MainActor class SavedPokemonViewModel: ObservableObject {
	private let savedPokemonKey = "savedPokemon"

	@Published var savedPokemons: [Pokemon] = []
	
	var currentPokemon: PKMPokemon?
	
	init() {
		loadSavedPokemons()
	}
	
	private func loadSavedPokemons() {
		if let savedPokemons = UserDefaults.standard.array(forKey: savedPokemonKey) as? [Pokemon] {
			self.savedPokemons = savedPokemons
		}
	}

	func saveCurrentPokemon() {
		// Logic to save the current Pokémon
		if let pokemon = currentPokemon {
			// Check if the pokemon is already saved
			guard !savedPokemons.contains(where: { $0.name == pokemon.name }) else {
				return
			}

			let newPokemon = Pokemon(pokemon)
			savedPokemons.append(newPokemon)
			UserDefaults.standard.set(savedPokemons, forKey: savedPokemonKey)
		}
	}
	
	func takeSelectedPokemon() {
		
	}
}

struct Pokemon: Identifiable {
	let id = UUID()
	let name: String
	
	init(_ pokemon: PKMPokemon) {
		self.name = pokemon.name ?? "No name"
	}
}
