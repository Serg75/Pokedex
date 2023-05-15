//
//  PreviewData.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import Foundation
import PokemonAPI

struct PreviewData {
	
	static var Pokemon607: PKMPokemon = {
		return Bundle.main.decodeJSON("pokemon607", type: PKMPokemon.self)
	}()
}
