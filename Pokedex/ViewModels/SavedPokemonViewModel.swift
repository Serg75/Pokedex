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
		if let data = UserDefaults.standard.data(forKey: savedPokemonKey) {
			if let savedPokemons = try? JSONDecoder().decode([Pokemon].self, from: data) {
				self.savedPokemons = savedPokemons
			}
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
			if let encoded = try? JSONEncoder().encode(savedPokemons) {
				UserDefaults.standard.set(encoded, forKey: savedPokemonKey)
			}
		}
	}
}
