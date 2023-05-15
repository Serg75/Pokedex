//
//  EvolutionChainView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI

import SwiftUI
import PokemonAPI

struct EvolutionChainView: View {
	@ObservedObject var viewModel: EvolutionChainViewModel
	
	var body: some View {
		VStack {
			if let chain = viewModel.chain {
				EvolutionChainLinkView(link: chain.chain!)
					.padding()
			} else {
				ProgressView()
			}
		}
	}
}

struct EvolutionChainLinkView: View {
	@ObservedObject var viewModel: EvolutionChainLinkViewModel

	init(link: PKMClainLink) {
		viewModel = EvolutionChainLinkViewModel(link: link)
	}
	
	var body: some View {
		VStack {
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

struct EvolutionChainView_Previews: PreviewProvider {
	static var previews: some View {
		return EvolutionChainView(viewModel: EvolutionChainViewModel(chain: PreviewData.EvolutionChain))
	}
}