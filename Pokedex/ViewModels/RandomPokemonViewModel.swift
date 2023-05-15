//
//  RandomPokemonViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import Foundation
import PokemonAPI

@MainActor class RandomPokemonViewModel: ObservableObject {
	@Published var pokemon: PKMPokemon?
	
	private var isFetching = false

	init() {
		guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" else {
			return
		}

		fetchRandomPokemon()
	}
	
	init(pokemon: PKMPokemon) {
		self.pokemon = pokemon
	}

	func fetchRandomPokemon() {
		guard !isFetching else { return }
		isFetching = true

		Task {
			var pokemonID = -1
			var isValid = false
			do {
				let pokemons = try await PokemonAPI().pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 5))
				
				pokemonID = generateRandomPokemonID(pokemonsCount: pokemons.count!)
				
				let pokemon = try await PokemonAPI().pokemonService.fetchPokemon(pokemonID)
				isValid = true
				
				DispatchQueue.main.async {
					self.pokemon = pokemon
				}
				
			} catch HTTPError.serverResponse(HTTPStatus(rawValue: 404), _ ) {
				print("The web service returned status code 404")
			} catch {
				print(error.localizedDescription)
			}

			self.isFetching = false
			
			if !isValid {
				// refetch pokemon
				self.fetchRandomPokemon()
			}

		}
	}

	private func generateRandomPokemonID(pokemonsCount: Int) -> Int {
		Int.random(in: 1..<pokemonsCount)
	}
}