//
//  Item.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import Foundation

struct Item {
	let name: String
	let url: URL?
	
	init(name: String, url: URL? = nil) {
		self.name = name
		self.url = url
	}
}
