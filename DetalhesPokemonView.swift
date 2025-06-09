import SwiftUI
import SwiftData

struct DetalhesPokemonView: View {
    let pokemonName: String
    @Environment(\.modelContext) private var modelContext
    let usuario: String

    @StateObject private var viewModel: DetalhesPokemonViewModel

    init(pokemonName: String, usuario: String, modelContext: ModelContext) {
        self.pokemonName = pokemonName
        self.usuario = usuario
        self._viewModel = StateObject(wrappedValue: DetalhesPokemonViewModel(context: modelContext, usuario: usuario))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Carregando…")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let pokemon = viewModel.pokemon {
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                            case .failure:
                                Image(systemName: "xmark.circle")
                            @unknown default:
                                EmptyView()
                            }
                        }

                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .bold()

                        HStack {
                            Text("ID: #\(pokemon.pokedexId)")
                            Spacer()
                            Text("Altura: \(pokemon.height)")
                            Spacer()
                            Text("Peso: \(pokemon.weight)")
                        }
                        .font(.subheadline)
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tipos")
                                .font(.headline)
                            HStack {
                                ForEach(pokemon.types, id: \.slot) { slot in
                                    Text(slot.type.name.capitalized)
                                        .padding(6)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Habilidades")
                                .font(.headline)
                            ForEach(pokemon.abilities, id: \.ability.name) { ability in
                                Text(ability.ability.name.capitalized)
                            }
                        }

                        Button {
                            viewModel.toggleFavorito()
                        } label: {
                            Label(
                                viewModel.isFavorito ? "Remover dos Favoritos" : "Favoritar",
                                systemImage: viewModel.isFavorito ? "star.fill" : "star"
                            )
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.isFavorito ? Color.red.opacity(0.8) : Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                Text("Erro: \(error)")
            }
        }
        .navigationTitle("Detalhes")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            await viewModel.fetchPokemon(named: pokemonName)
        }
    }
}
