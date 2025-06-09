import Foundation

@MainActor
class ListaPokemonViewModel: ObservableObject {
    @Published var pokemons: [NamedAPIResource] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: PokemonServiceProtocol
    private var offset = 0
    private let limit = 20
    private var canLoadMore = true

    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }

    func fetchPokemons() async {
        guard !isLoading && canLoadMore else { return }
        isLoading = true
        do {
            let result = try await service.fetchPokemonList(limit: limit, offset: offset)
            pokemons.append(contentsOf: result.results)
            offset += limit
            canLoadMore = result.results.count == limit
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func reset() {
        pokemons = []
        offset = 0
        canLoadMore = true
    }
}
