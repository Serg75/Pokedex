# Pokemon Evolution Chain

This project demonstrates the evolution chain of Pokemon using data from the PokemonAPI.\
\
It was created as a test assignment - see Requirements.pdf.

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
- `PokemonServiceProtocol`: This file defines the PokemonServiceProtocol, which is a protocol specifying a subset of the PKMPokemonService methods used in the code. This protocol reduces the amount of code needed for creating mocks and simplifies testing.
- `TaskExecutor`: This file contains the struct, which provides a method that executes a given task repeatedly until the task returns true or the maximum attempt count is reached. The delay between each execution increases exponentially.
- `PreviewData`: A struct providing preview data for SwiftUI previews.
- `RandomPokemonViewModelTests`: This class contains unit tests for the `RandomPokemonViewModel` class, which is responsible for providing the data and logic for the random Pokemon feature in the Pokedex app.
- `TaskExecutorTests`: This class contains unit tests for the `TaskExecutor` class, which is responsible for executing tasks asynchronously with repetition until they succeed.
- `XCTestCase+Combine`: This code extension adds a utility method to the `XCTestCase` class for handling expectations on publishers with the `@Published` property wrapper.
