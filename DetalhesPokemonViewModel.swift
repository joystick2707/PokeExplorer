import SwiftData
import Foundation

@MainActor
class DetalhesPokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var isFavorito = false
    private let service: PokemonServiceProtocol
    private let favoritoRepo: FavoritoRepository
    private let usuario: String

    init(service: PokemonServiceProtocol = PokemonService(), context: ModelContext, usuario: String) {
        self.service = service
        self.favoritoRepo = FavoritoRepository(context: context)
        self.usuario = usuario
    }

    func fetchPokemon(named name: String) async {
        do {
            let result = try await service.fetchPokemon(nome: name)
            self.pokemon = result
            let id = result.id // sem if let porque id não é Optional
            self.isFavorito = favoritoRepo.isFavorito(id: id, usuario: usuario)
        } catch {
            print("Erro ao buscar Pokémon:", error)
        }
    }


    func toggleFavorito() {
        guard let pokemon = pokemon else { return }
        if isFavorito {
            if let favorito = favoritoRepo.buscarPorId(pokemon.pokedexId, usuario: usuario) {
                favoritoRepo.remover(favorito: favorito)
            }
        } else {
            favoritoRepo.adicionar(pokemon: pokemon, usuario: usuario)
        }
        isFavorito.toggle()
    }
}
