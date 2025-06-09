import Foundation

struct Pokemon: Decodable, Identifiable {
    var id: Int { pokedexId }
    let pokedexId: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonTypeSlot]
    let abilities: [PokemonAbilitySlot]
    let sprites: PokemonSprites

    enum CodingKeys: String, CodingKey {
        case name, height, weight, types, abilities, sprites
        case pokedexId = "id"
    }
}

struct PokemonTypeSlot: Decodable {
    let slot: Int
    let type: NamedAPIResource
}

struct PokemonAbilitySlot: Decodable {
    let ability: NamedAPIResource
}

struct PokemonSprites: Decodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
