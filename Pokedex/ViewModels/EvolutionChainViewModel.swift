//
//  EvolutionChainViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI
import PokemonAPI

@MainActor class EvolutionChainViewModel: ObservableObject {
	@Published var chain: PKMEvolutionChain?
	
	init() {
		fetchEvolutionChain()
	}
	
	init(chain: PKMEvolutionChain) {
		self.chain = chain
	}
	
	func fetchEvolutionChain() {
		PokemonAPI().evolutionService.fetchEvolutionChain(1) { result in
			switch result {
			case .success(let chain):
				DispatchQueue.main.async {
					self.chain = chain
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
