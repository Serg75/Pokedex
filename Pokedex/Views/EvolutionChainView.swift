//
//  EvolutionChainView.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-05-15.
//

import SwiftUI
import PokemonAPI

struct EvolutionChainView: View {
	@ObservedObject var viewModel: EvolutionChainViewModel
	
	var body: some View {
		ScrollView {
			VStack {
				if let chain = viewModel.chain {
					EvolutionChainLinkView(link: chain.chain!)
				} else {
					ProgressView()
				}
			}
		}
	}
}

struct EvolutionChainView_Previews: PreviewProvider {
	static var previews: some View {
		return EvolutionChainView(viewModel: EvolutionChainViewModel(chain: PreviewData.EvolutionChain308))
	}
}
