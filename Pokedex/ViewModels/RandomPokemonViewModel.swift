//
//  RandomPokemonViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import Foundation
import PokemonAPI

@MainActor class RandomPokemonViewModel: ObservableObject {
	@Published var currentPokemon: PKMPokemon?
	@Published var evolutionChain: PKMEvolutionChain?
	
	let pokemonService: PokemonServiceProtocol
	let taskExecutor: TaskExecutorProtocol

	private var isFetching = false

	init(pokemonService: PokemonServiceProtocol = PokemonAPI().pokemonService,
		 taskExecutor: TaskExecutorProtocol = TaskExecutor()) {
		self.pokemonService = pokemonService
		self.taskExecutor = taskExecutor
	}
	
	init(pokemon: PKMPokemon,
		 pokemonService: PokemonServiceProtocol = PokemonAPI().pokemonService,
		 taskExecutor: TaskExecutorProtocol = TaskExecutor()) {

		self.currentPokemon = pokemon
		self.pokemonService = pokemonService
		self.taskExecutor = taskExecutor

		Task {
			await fetchEvolutionChain(pokemonId: pokemon.id)
		}
	}

	func fetchRandomPokemon() async {
		var pokemonCount = 0
		
		let countWasFetched = await taskExecutor.runUntilSuccess(attemptCount: 10) {
			var success = false
			do {
				let pokemons = try await self.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 5))
				pokemonCount = pokemons.count!
				success = true
			} catch {
				print("Fetching pokemon list failed with error: \(error.localizedDescription)")
			}

			return success
		}
		
		guard countWasFetched else { return }
		
		// generateRandomPokemonID has an assertion, no need extra one here
		guard let pokemonID = try? self.generateRandomPokemonID(pokemonCount: pokemonCount) else { return }
		
		await fetchExactPokemon(id: pokemonID)
	}
	
	func fetchExactPokemon(id: Int) async {
		let success = await taskExecutor.runUntilSuccess(attemptCount: 10) {
			await fetchPokemon(pokemonId: id)
		}
		guard success else {
			print("Fetching pokemon didn't have success after several attempts")
			return
		}

		let anotherSuccess = await taskExecutor.runUntilSuccess(attemptCount: 10) {
			await fetchEvolutionChain(pokemonId: id)
		}
		if !anotherSuccess {
			print("Fetching evolution chain didn't have success after several attempts")
		}
	}
	
	func fetchPokemon(pokemonId: Int) async -> Bool {
		guard pokemonId > 0 else { return false }
		guard !isFetching else { return false }
		isFetching = true
		var isValid = false

		currentPokemon = nil
		var pokemon: PKMPokemon?
		do {
			pokemon = try await pokemonService.fetchPokemon(pokemonId)
			isValid = true
		} catch HTTPError.serverResponse(HTTPStatus(rawValue: 404), _ ) {
			print("The web service returned status code 404")
		} catch {
			print(error.localizedDescription)
		}

		self.isFetching = false
		
		if isValid {
			DispatchQueue.main.async {
				self.currentPokemon = pokemon
			}
		}
		
		return isValid
	}

	private func generateRandomPokemonID(pokemonCount: Int) throws -> Int {
		assert(pokemonCount > 0, "pokemonCount should be > 0")
		return Int.random(in: 1..<pokemonCount)
	}
	
	func fetchEvolutionChain(pokemonId: Int?) async -> Bool {
		do {
			let species = try await PokemonAPI().pokemonService.fetchPokemonSpecies(pokemonId!)
			let evoChainURL = URL(string: (species.evolutionChain?.url)!)
			let evolutionChain = try await PokemonAPI().evolutionService.fetchEvolutionChain((evoChainURL?.extractedID!)!)
			
			DispatchQueue.main.async {
				self.evolutionChain = evolutionChain
			}
			
			return true
			
		} catch {
			print("Fetching pokemon species / evolution chain failed with error: \(error.localizedDescription)")
			
			return false
		}
	}
}
