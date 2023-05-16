//
//  AlertItem.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI

struct AlertItem: Identifiable {
	let id = UUID()
	var title: Text
	var message: Text
	var dismissButton: Alert.Button
}
