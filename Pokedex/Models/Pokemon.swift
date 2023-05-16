//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-17.
//

import Foundation
import PokemonAPI

struct Pokemon : Codable, Identifiable, Hashable {
	let id: Int
	let name: String
	
	init(_ pokemon: PKMPokemon) {
		self.id = pokemon.id ?? 0
		self.name = pokemon.name ?? "No name"
	}
}
