//
//  EvolutionChainLinkView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI
import PokemonAPI

struct EvolutionChainLinkView: View {
	@ObservedObject var viewModel: EvolutionChainLinkViewModel

	init(link: PKMClainLink) {
		viewModel = EvolutionChainLinkViewModel(link: link)
	}
	
	var body: some View {
		VStack {
			AsyncImage(url: viewModel.speciesImage)
				.frame(width: 50, height: 50)
				.padding(0)
			Text(viewModel.speciesName)
				.padding(0)
				.font(.headline)
			
			if let evolvesTo = viewModel.evolvesTo {
				VStack {
					ForEach(0..<evolvesTo.count, id: \.self) { index in
						let evolution = evolvesTo[index]
						HStack {
							Image(systemName: "arrow.down")
								.resizable()
								.frame(width: 25, height: 40)
								.foregroundColor(.blue)
						}
						
						// next chain link
						EvolutionChainLinkView(link: evolution)
					}
				}
			}
		}
		.padding()
	}
}

struct EvolutionChainLinkView_Previews: PreviewProvider {
    static var previews: some View {
		EvolutionChainLinkView(link: PreviewData.EvolutionChain308.chain!)
    }
}
