import SwiftUI

struct ListaPokemonView: View {
    @StateObject private var viewModel = ListaPokemonViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemons) { pokemon in
                        NavigationLink(destination: DetalhesPokemonView(pokemonName: pokemon.name)) {
                            PokemonGridItemView(pokemon: pokemon)
                                .onAppear {
                                    if pokemon == viewModel.pokemons.last {
                                        Task { await viewModel.fetchPokemons() }
                                    }
                                }
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView().padding()
                    }
                }
                .padding()
            }
            .navigationTitle("PokéExplorer")
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }
}
