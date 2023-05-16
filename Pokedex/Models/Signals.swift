//
//  Signals.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import Foundation

enum PokemonType {
	case random
	case exact(Int)
}

@MainActor class Signals: ObservableObject {
	@Published var changePokemon = false
	var pokemonType: PokemonType?
}
