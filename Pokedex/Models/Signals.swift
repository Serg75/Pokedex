//
//  Signals.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import Foundation

@MainActor class Signals: ObservableObject {
	@Published var askRandomPokemon = false
}
