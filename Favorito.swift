import Foundation
import SwiftData

@Model
class Favorito {
    @Attribute(.unique) var id: Int
    var nome: String
    var imagemURL: String
    var usuario: String  // ou use um relacionamento se já tiver um modelo Usuario

    init(id: Int, nome: String, imagemURL: String, usuario: String) {
        self.id = id
        self.nome = nome
        self.imagemURL = imagemURL
        self.usuario = usuario
    }
}
