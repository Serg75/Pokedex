//
//  PresentedItem.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//
//  A Pokemon item to be presented on the view, with a name and optional URL.

import Foundation
import PokemonAPI

struct PresentedItem {
	let name: String
	let url: URL?
	
	init(name: String, url: URL? = nil) {
		self.name = name
		self.url = url
	}
	
	init(item: PKMItem) {
		let name = item.name ?? "Unknown item"
		if let url = URL(string: item.sprites?.default ?? "") {
			self.init(name: name, url: url)
		} else {
			self.init(name: name)
		}
	}
}
