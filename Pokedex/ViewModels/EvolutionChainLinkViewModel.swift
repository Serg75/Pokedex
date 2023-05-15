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
	@Published var speciesImage: URL?
	@Published var evolvesTo: [PKMClainLink]?
	@Published var items: [PKMClainLink: PKMItem?] = [:]
	@Published var heldItems: [PKMClainLink: PKMItem?] = [:]
	
	init(link: PKMClainLink) {
		self.link = link
		fetchSpeciesName()
		fetchSpeciesImage()
		fetchEvolvesTo()
	}
	
	private func fetchSpeciesName() {
		guard let species = link.species else { return }
		
		speciesName = species.name ?? ""
	}
	
	private func fetchSpeciesImage() {
		if let resource = link.species {
			Task {
				do {
					let species = try await PokemonAPI().resourceService.fetch(resource)
					if let id = species.id {
						let pokemon = try await PokemonAPI().pokemonService.fetchPokemon(id)
						if let url = URL(string: pokemon.sprites?.frontDefault ?? "") {
							speciesImage = url
						}
					}
				} catch {
					print(error)
				}
			}
		}
	}
	
	private func fetchEvolvesTo() {
		guard let evolvesTo = link.evolvesTo else { return }
		
		self.evolvesTo = evolvesTo
		fetchEvolutionItems()
	}
	
	private func fetchEvolutionItems() {
		guard let evolutions = evolvesTo else { return }
		
		Task {
			for evolution in evolutions {
				items[evolution] = await fetchItem(for: evolution)
				heldItems[evolution] = await fetchHeldItem(for: evolution)
			}
		}
	}
	
	private func fetchItem(for evolution: PKMClainLink) async -> PKMItem? {
		guard let details = evolution.evolutionDetails else { return nil }
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
	
	private func fetchHeldItem(for evolution: PKMClainLink) async -> PKMItem? {
		guard let details = evolution.evolutionDetails else { return nil }
		let resources = details.compactMap({ detail in
			detail.heldItem
		})
		guard let resource = resources.first else { return nil }
		
		do {
			return try await PokemonAPI().resourceService.fetch(resource)
		} catch {
			print(error)
		}
		
		return nil
	}
	
	func itemFor(evolution: PKMClainLink) -> Item? {
		if let item = items[evolution] ?? nil {
			let name = item.name ?? "Unknown item"
			if let url = URL(string: item.sprites?.default ?? "") {
				return Item(name: name, url: url)
			}
			return Item(name: name)
		}
		return nil
	}
	
	func heldItemFor(evolution: PKMClainLink) -> Item? {
		if let item = heldItems[evolution] ?? nil {
			let name = item.name ?? "Unknown item"
			if let url = URL(string: item.sprites?.default ?? "") {
				return Item(name: name, url: url)
			}
			return Item(name: name)
		}
		return nil
	}

	func minLevelFor(evolution: PKMClainLink) -> Int? {
		if let details = evolution.evolutionDetails?.first {
			return details.minLevel
		}
		return nil
	}
	
	func hasEvolutionInfo(evolution: PKMClainLink) -> Bool {
		return itemFor(evolution: evolution) != nil
		|| heldItemFor(evolution: evolution) != nil
		|| minLevelFor(evolution: evolution) != nil
	}
}

extension PKMClainLink: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(species?.url)
	}

	public static func == (lhs: PKMClainLink, rhs: PKMClainLink) -> Bool {
		return lhs.species?.url == rhs.species?.url
	}
}
