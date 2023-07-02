//
//  AlertItem.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//
//  Used to show a message with dismiss button.

import SwiftUI

struct AlertItem: Identifiable {
	let id = UUID()
	var title: Text
	var message: Text
	var dismissButton: Alert.Button
}
