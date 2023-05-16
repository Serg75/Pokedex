//
//  ParentsView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI
import PokemonAPI

struct ParentsView: View {
	@StateObject private var viewModel = ParentsViewModel()
	
	@Binding var pokemon: PKMPokemon?
	
	let onDismiss: () -> Void
	
	let digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0"]
	
	var body: some View {
		ZStack {
			if !viewModel.showSecondView {
				VStack {
					Text("Enter the code:")
						.font(.title)
						.padding(.bottom, 20)
					
					LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
						ForEach(digits, id: \.self) { digit in
							if !digit.isEmpty {
								Button(action: {
									viewModel.addDigit(digit)
								}) {
									Text(digit)
										.font(.title)
										.frame(width: 80, height: 80)
										.background(Color.blue)
										.foregroundColor(.white)
										.cornerRadius(40)
								}
							} else {
								Text("")
							}
						}
					}
					
					HStack {
						Button("Close") {
							// Dismiss the view
							onDismiss()
						}
						.foregroundColor(.blue)
						// to have equal width for left and right views
						.frame(maxWidth: .infinity)
						
						Spacer()
						
						Button("Enter") {
							viewModel.checkCode()
						}
						.foregroundColor(.blue)
						// to have equal width for left and right views
						.frame(maxWidth: .infinity)
						
						Spacer()
					}
					.font(.title2)
					.padding(.top, 20)
					.padding(.bottom, 10)
				}
				.padding()
				.background(Color.white)
				.cornerRadius(10)
				.shadow(radius: 10)
				.transition(.move(edge: .leading))
			}
			
			if viewModel.showSecondView {
				SavedPokemonView(pokemon: pokemon, onDismiss: {
					// Dismiss whole view
					onDismiss()
				})
				.transition(.move(edge: .trailing))
			}
		}
		.animation(.easeInOut)
		.onAppear {
			// Clear the code when the view appears
			viewModel.clearCode()
		}
	}
}

struct ParentsView_Previews: PreviewProvider {
    static var previews: some View {
		@State var pokemon: PKMPokemon? = nil
		ParentsView(pokemon: $pokemon, onDismiss: {})
    }
}
