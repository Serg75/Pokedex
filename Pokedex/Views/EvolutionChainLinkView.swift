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
		VStack(alignment: .center) {
			AsyncImage(url: viewModel.speciesImage)
				.frame(width: 50, height: 50)
				.padding(0)
			Text(viewModel.speciesName)
				.padding(0)
				.font(.headline)
				.frame(maxWidth: .infinity)
			
			if let evolvesTo = viewModel.evolvesTo {
				HStack(alignment: .bottom) {
					ForEach(0..<evolvesTo.count, id: \.self) { index in
						let evolution = evolvesTo[index]
						VStack {
							Image(systemName: "rectangle.portrait.fill")
								.resizable()
								.frame(width: 3, height: 15)
								.foregroundColor(.blue)
							
							evolutionCondition(evolution: evolution)
								.zIndex(1)
							
							Image(systemName: "rectangle.portrait.fill")
								.resizable()
								.frame(width: 3, height: 15)
								.foregroundColor(.blue)
								.padding(.top, -5)
							Image(systemName: "arrowtriangle.down.fill")
								.resizable()
								.frame(width: 15, height: 15)
								.foregroundColor(.blue)
								.padding(.top, -10)
							
							// next chain link
							EvolutionChainLinkView(link: evolution)
						}
					}
				}
			}
		}
		.padding()
	}
	
	@ViewBuilder
	private func evolutionCondition(evolution: PKMClainLink) -> some View {
		if viewModel.hasEvolutionInfo(evolution: evolution) {
			outlignedVew(view:
				VStack {
					if let level = viewModel.minLevelFor(evolution: evolution) {
						Text("Level \(level)")
							.font(.caption)
					}

					if let item = viewModel.itemFor(evolution: evolution) {
						EvolutionItemView(item: item)
					}
					
					if let item = viewModel.heldItemFor(evolution: evolution) {
						EvolutionHeldItemView(item: item)
					}
				}
			)
		} else {
			VStack { }
		}
	}
	
	@ViewBuilder
	private func outlignedVew(view: some View) -> some View {
		view
		.padding(.horizontal, 10)
		.padding(.vertical, 3)
		.background(Color(.systemGray6).opacity(0.9))
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.strokeBorder(.gray, lineWidth: 0.7)
		)
		.frame(maxWidth: .infinity)
		.padding(.vertical, -8)
	}
}

struct EvolutionItemView: View {
	let item: PresentedItem

	var body: some View {
		HStack {
			if let url = item.url {
				AsyncImage(url: url)
			}
			VStack {
				Text("use")
					.font(.caption)
				Text("\(item.name)")
					.font(.caption)
					.bold()
			}
			.frame(minWidth: 50)
		}
	}
}

struct EvolutionChainLinkView_Previews: PreviewProvider {
	static var previews: some View {
		EvolutionChainLinkView(link: PreviewData.EvolutionChain26.chain!)
	}
}
