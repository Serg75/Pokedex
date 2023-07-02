//
//  TestApp.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-25.
//
// Entry point for tests. We prevent to run UI in the test config.

import SwiftUI

struct TestApp: App {
	var body: some Scene {
		WindowGroup { Text("Running Unit Tests") }
	}
}
