//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI

struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
			RandomPokemonView(viewModel: RandomPokemonViewModel())
        }
    }
}
