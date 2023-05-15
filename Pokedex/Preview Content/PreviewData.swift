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
	
	static var EvolutionChain26: PKMEvolutionChain = {
		return Bundle.main.decodeJSON("evolution_chain26", type: PKMEvolutionChain.self)
	}()
	
	static var EvolutionChain308: PKMEvolutionChain = {
		return Bundle.main.decodeJSON("evolution_chain308", type: PKMEvolutionChain.self)
	}()
}
