//
//  RandomPokemonViewModelTests.swift
//  PokedexTests
//
//  Created by Sergey Slobodenyuk on 2023-05-24.
//

import XCTest
import Combine
import PokemonAPI

@testable import Pokedex

final class RandomPokemonViewModelTests: XCTestCase {
	
	class MockPokemonService: PokemonServiceProtocol {
		func decodeJSON<T: Decodable>(_ json: String, type: T.Type) -> T {
			let data = Data(json.utf8)
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			decoder.dateDecodingStrategy = .iso8601
			return try! decoder.decode(type, from: data)
		}

		func fetchPokemon(_ pokemonID: Int) async throws -> PKMPokemon {
			let data = "{\"id\":\(pokemonID)}"
			let result = decodeJSON(data, type: PKMPokemon.self)
			return result
		}
		
		func fetchPokemonList<T>(paginationState: PaginationState<T>) async throws -> PKMPagedObject<T> where T : PKMPokemon {
			let count = 1000
			let data = "{\"count\":\(count)}"
			let result = decodeJSON(data, type: PKMPagedObject<T>.self)
			return result
		}
	}
	
	struct MockTaskExecutor: TaskExecutorProtocol {
		func runUntilSuccess(attemptCount: Int, task: () async -> Bool) async -> Bool {
			return await task()
		}
	}
	
	var mockPokemonService: PokemonServiceProtocol!	// mock implementation of the PokemonService
	var mockTaskExecutor: TaskExecutorProtocol!		// mock implementation of the TaskExecutor

	
	override func setUpWithError() throws {
		mockPokemonService = MockPokemonService()
		mockTaskExecutor = MockTaskExecutor()
	}


	@MainActor func testInitialState() {
		
		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)
		
		// Check if the currentPokemon is nil
		XCTAssertNil(viewModel.currentPokemon)

		// Check if the evolutionChain is nil
		XCTAssertNil(viewModel.evolutionChain)
	}
	
	@MainActor func testFetchEvolutionChain() async {
		
		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)

		// Set expectation for changing $evolutionChain value
		let exp = expectValue(of: viewModel.$evolutionChain,
							  equality: { $0 != nil })

		// Perform the fetchEvolutionChain method
		_ = await viewModel.fetchEvolutionChain(pokemonId: 1)
		
		// Wait for expectation
		await fulfillment(of: [exp.expectation], timeout: 1)

		// Check if the evolutionChain is not nil
		XCTAssertNotNil(viewModel.evolutionChain)
	}
	
	@MainActor func testFetchPokemon() async {
		
		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)

		// Set expectation for changing $currentPokemon value
		let exp = expectValue(of: viewModel.$currentPokemon,
							  equality: { $0 != nil })

		// Perform the fetchPokemon method
		let result = await viewModel.fetchPokemon(pokemonId: 200)
		XCTAssertTrue(result)
		
		// Wait for expectation
		await fulfillment(of: [exp.expectation], timeout: 1)

		// Check if the currentPokemon has desired id
		XCTAssertEqual(viewModel.currentPokemon?.id, 200)
	}
	
	@MainActor func testFetchPokemon_InvalidID() async {

		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)

		// Set inverted expectation for changing $currentPokemon value
		let exp = expectValue(of: viewModel.$currentPokemon,
							  isInverted: true,
							  equality: { $0 != nil })

		// Perform the fetchPokemon method with an invalid ID
		let result = await viewModel.fetchPokemon(pokemonId: -1)
		XCTAssertFalse(result)
		
		// Wait for expectation
		await fulfillment(of: [exp.expectation], timeout: 1)

		// Check if the currentPokemon is not set
		XCTAssertNil(viewModel.currentPokemon)
	}
	
	@MainActor func testFetchExactPokemon() async {
		
		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)

		// Set expectation for changing $currentPokemon value
		let exp1 = expectValue(of: viewModel.$currentPokemon,
							   equality: { $0 != nil })

		// Set expectation for changing $evolutionChain value
		let exp2 = expectValue(of: viewModel.$evolutionChain,
							   equality: { $0 != nil })

		// Perform the fetchExactPokemon method
		await viewModel.fetchExactPokemon(id: 1)
		
		// Wait for expectations
		await fulfillment(of: [exp1.expectation, exp2.expectation], timeout: 1)

		// Check if the currentPokemon has desired id
		XCTAssertEqual(viewModel.currentPokemon?.id, 1)

		// Check if the evolutionChain is not nil
		XCTAssertNotNil(viewModel.evolutionChain)
	}
	
	@MainActor func testFetchExactPokemon_InvalidID() async {

		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)

		// Set inverted expectation for changing $currentPokemon value
		let exp1 = expectValue(of: viewModel.$currentPokemon,
							   isInverted: true,
							   equality: { $0 != nil })

		// Set inverted expectation for changing $evolutionChain value
		let exp2 = expectValue(of: viewModel.$evolutionChain,
							   isInverted: true,
							   equality: { $0 != nil })

		// Perform the fetchExactPokemon method with an invalid ID
		await viewModel.fetchExactPokemon(id: -1)
		
		// Wait for expectations
		await fulfillment(of: [exp1.expectation, exp2.expectation], timeout: 1)

		// Check if the currentPokemon is not set
		XCTAssertNil(viewModel.currentPokemon)

		// Check if the evolutionChain is not set
		XCTAssertNil(viewModel.evolutionChain)
	}
	
	@MainActor func testFetchRandomPokemon() async {
		
		// Set the mocks on the ViewModel
		let viewModel = RandomPokemonViewModel(pokemonService: mockPokemonService,
											   taskExecutor: mockTaskExecutor)

		// Set expectation for changing $currentPokemon value
		let exp = expectValue(of: viewModel.$currentPokemon,
							  equality: { $0 != nil })

		// Perform the fetchRandomPokemon method
		await viewModel.fetchRandomPokemon()
		
		// Wait for expectation
		await fulfillment(of: [exp.expectation], timeout: 1)

		// Check if the currentPokemon is not nil
		XCTAssertNotNil(viewModel.currentPokemon)
	}
	
}
