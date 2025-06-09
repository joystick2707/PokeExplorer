import Foundation

class PokemonService: PokemonServiceProtocol {
    private let baseURL = "https://pokeapi.co/api/v2"

    func fetchPokemonList(limit: Int = 20, offset: Int = 0) async throws -> PokemonListResponse {
        let urlString = "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResp = response as? HTTPURLResponse, httpResp.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return decoded
    }

    func fetchPokemon(nome: String) async throws -> Pokemon {
        let urlString = "\(baseURL)/pokemon/\(nome.lowercased())"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResp = response as? HTTPURLResponse, httpResp.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
        return decoded
    }
}
