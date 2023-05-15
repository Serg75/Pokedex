//
//  URL-ID.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import Foundation

extension URL {
	var extractedID: Int? {
		let components = path.components(separatedBy: "/")
		guard let idString = components.last, let id = Int(idString) else {
			return nil
		}
		return id
	}
}
