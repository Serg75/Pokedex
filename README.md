# Pokemon Evolution Chain

This project demonstrates the evolution chain of Pokemon using data from the PokemonAPI.

## Features

- Display the evolution chain of a selected Pokemon.
- Show the species name and image for each link in the evolution chain.
- Display evolution conditions such as minimum level, required item, and held item.
  Note: held items are not shown due to a bug in PokemonAPI package.
- Save and view a list of saved Pokemon.
- Enter a code to unlock additional content.

## Usage

1. Launch the app on your iOS device or simulator.
2. Random Pokemon with its evolution chain appears on the screen.
3. The evolution conditions, such as minimum level and required items, are displayed when available.
4. To access additional content, tap an icon in the bottom-right corner and enter the code (1256) then press Enter. 
5. You can save a Pokemon to your list of saved Pokemon or open new random.

## Code Structure

The project is structured as follows:

- `AlertItem`: An alert item with a title, message, and dismiss button.
- `PresentedItem`: A Pokemon item to be presented on the view, with a name and optional URL.
- `PokemonType`: An enumeration used in sending commands from child view to the distant parent.
- `Signals`: Used in sending commands from child view to the distant parent.
- `Pokemon`: Used to save Pokemons in User Defaults.
- `EvolutionChainViewModel`: An observable object managing the evolution chain data.
- `EvolutionChainLinkViewModel`: An observable object managing the evolution chain link data.
- `ParentsViewModel`: An observable object managing the code entry and access to additional content.
- `RandomPokemonViewModel`: An observable object managing the random Pokemon selection and evolution chain fetching (main view model).
- `SavedPokemonViewModel`: An observable object managing the saved Pokemon list and persistence.
- `EvolutionChainView`: A SwiftUI view displaying the evolution chain.
- `EvolutionChainLinkView`: A SwiftUI view displaying a single link in the evolution chain.
- `EvolutionItemView`: A SwiftUI view displaying an evolution item.
- `EvolutionHeldItemView`: A SwiftUI view displaying an evolution held item.
- `PreviewData`: A struct providing preview data for SwiftUI previews.
