//
//  AppLauncher.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-25.
//
//  The entry point where we run either the app or tests.

import Foundation

@main
struct AppLauncher {
	static func main() throws {
		if NSClassFromString("XCTestCase") == nil {
			PokedexApp.main()
		} else {
			TestApp.main()
		}
	}
}
