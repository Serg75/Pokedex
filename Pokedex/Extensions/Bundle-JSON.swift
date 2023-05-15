//
//  Bundle+JSON.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import Foundation

extension Bundle {

	func decodeJSON<T: Decodable>(_ name: String, type: T.Type) -> T {
		let url = Bundle.main.url(forResource: name, withExtension: "json")!
		let data = try! Data(contentsOf: url)
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
		return try! decoder.decode(type, from: data)
	}
}
