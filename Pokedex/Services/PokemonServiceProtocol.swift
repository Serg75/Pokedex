//
//  PokemonServiceProtocol.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-24.
//

import Foundation
import PokemonAPI


/// A small peace of PKMPokemonService protocol used in our code.
/// This approach reduces amount of code needed for mocks.
protocol PokemonServiceProtocol {
	func fetchPokemon(_ pokemonID: Int) async throws -> PKMPokemon
	func fetchPokemonList<T>(paginationState: PaginationState<T>) async throws -> PKMPagedObject<T> where T: PKMPokemon
}

// Make PokemonService struct conform to the protocol
extension PokemonService: PokemonServiceProtocol { }
