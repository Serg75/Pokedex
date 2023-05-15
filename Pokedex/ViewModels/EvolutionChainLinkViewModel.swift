//
//  EvolutionChainLinkViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import Foundation
import PokemonAPI

@MainActor class EvolutionChainLinkViewModel: ObservableObject {
	private let link: PKMClainLink
	private let evolutionService = PokemonAPI().evolutionService
	
	@Published var speciesName: String = ""
	@Published var evolvesTo: [PKMClainLink]?
	@Published var evolutionItems: [PKMItem?] = []
	
	init(link: PKMClainLink) {
		self.link = link
		fetchSpeciesName()
		fetchEvolvesTo()
	}
	
	private func fetchSpeciesName() {
		guard let species = link.species else { return }

		speciesName = species.name ?? ""
	}
	
	private func fetchEvolvesTo() {
		guard let evolvesTo = link.evolvesTo else { return }
		
		self.evolvesTo = evolvesTo
		fetchEvolutionItems()
	}
	
	func fetchEvolutionItems() {
		guard let evolutions = evolvesTo else { return }

		Task {
			evolutionItems = Array(repeating: nil, count:evolutions.count)
			for i in 0..<evolutions.count {
				evolutionItems[i] = await fetchEvolutionItem(for: evolutions[i])
			}
		}
	}
	
	func fetchEvolutionItem(for evolution: PKMClainLink) async -> PKMItem? {
		guard let details = evolution.evolutionDetails else { return nil }
//		guard let resource = details.first?.item else { return nil }
		let resources = details.compactMap({ detail in
			detail.item
		})
		guard let resource = resources.first else { return nil }
		
		do {
			return try await PokemonAPI().resourceService.fetch(resource)
		} catch {
			print(error)
		}
		
		return nil
	}
	
}
