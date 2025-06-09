//
//  PokeExplorerApp.swift
//  PokeExplorer
//
//  Created by Bryan Strey on 09/06/25.
//

import SwiftUI

@main
struct PokeExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            ListaPokemonView(usuarioLogado: "ash@kanto.com") // exemplo
        }
        .modelContainer(for: [Favorito.self])
    }
}
