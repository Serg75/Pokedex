//
//  ParentsViewModel.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI

@MainActor class ParentsViewModel: ObservableObject {
	@Published var code = ""
	let correctCode = "1256"	// hardcoded code, wil be improved in the next versions
	@Published var alertItem: AlertItem?
	@Published var showSecondView = false
	
	func addDigit(_ digit: String) {
		code.append(digit)
	}
	
	func checkCode() {
		if code == correctCode {
			// The code is correct, show the new content
			code = ""
			showSecondView = true
		} else {
			// The code is incorrect, show an alert
			alertItem = AlertItem(title: Text("Error"), message: Text("The code is incorrect"), dismissButton: .default(Text("OK")))
			code = ""
		}
	}
	
	func clearCode() {
		code = ""
	}
}
