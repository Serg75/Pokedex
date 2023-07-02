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


/// A class used in sending commands from child view to the distant parent.
@MainActor class Signals: ObservableObject {
	/// A flag that triggered when signal sending.
	@Published var changePokemon = false
	
	/// Random or specified by id.
	var pokemonType: PokemonType?
}
