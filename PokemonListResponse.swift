import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let results: [NamedAPIResource]
}

struct NamedAPIResource: Decodable, Identifiable {
    var id: String { name } // Para List em SwiftUI
    let name: String
    let url: String
}
