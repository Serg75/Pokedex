//
//  EvolutionHeldItemView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-16.
//

import SwiftUI

struct EvolutionHeldItemView: View {
	let item: PresentedItem

	var body: some View {
		HStack {
			if let url = item.url {
				AsyncImage(url: url)
			}
			VStack {
				Text("trade holding")
					.font(.caption)
				Text("\(item.name)")
					.font(.caption)
					.bold()
			}
		}
	}
}

struct EvolutionHeldItemView_Previews: PreviewProvider {
	
	// ERROR!
	// We have an issue in preview due to an error in PKMItemHolderPokemon.
	// It declares pokemon as String? but in json it is a dictionary
    static var previews: some View {
		EvolutionHeldItemView(item: PresentedItem(item: PreviewData.EvolutionItem210))
    }
}
