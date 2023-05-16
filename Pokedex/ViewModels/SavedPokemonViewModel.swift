//
//  SavedPokemonViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import Foundation

@MainActor class SavedPokemonViewModel: ObservableObject {
	@Published var savedPokemons: [Pokemon] = []
	
	func saveCurrentPokemon() {
		// Logic to save the current Pokémon
		let newPokemon = Pokemon(name: "Charizard")
		savedPokemons.append(newPokemon)
	}
	
	func openNewRandomPokemon() {
		// Logic to open a new random Pokémon
	}
}

struct Pokemon: Identifiable {
	let id = UUID()
	let name: String
}
