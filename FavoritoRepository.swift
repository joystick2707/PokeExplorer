import Foundation
import SwiftData

class FavoritoRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func adicionar(pokemon: Pokemon, usuario: String) {
        let favorito = Favorito(
            id: pokemon.pokedexId,
            nome: pokemon.name,
            imagemURL: pokemon.sprites.frontDefault ?? "",
            usuario: usuario
        )
        context.insert(favorito)
    }

    func remover(favorito: Favorito) {
        context.delete(favorito)
    }

    func buscarTodos(usuario: String) -> [Favorito] {
        let descriptor = FetchDescriptor<Favorito>(predicate: #Predicate { $0.usuario == usuario })
        return (try? context.fetch(descriptor)) ?? []
    }

    func buscarPorId(_ id: Int, usuario: String) -> Favorito? {
        let descriptor = FetchDescriptor<Favorito>(predicate: #Predicate {
            $0.id == id && $0.usuario == usuario
        })
        return (try? context.fetch(descriptor).first)
    }

    func isFavorito(id: Int, usuario: String) -> Bool {
        return buscarPorId(id, usuario: usuario) != nil
    }
}
