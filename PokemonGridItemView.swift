import SwiftUI

struct PokemonGridItemView: View {
    let pokemon: NamedAPIResource
    
    var body: some View {
        VStack {
            Text(pokemon.name.capitalized)
                .font(.headline)
                .padding(.top, 8)
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(extractID()).png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 80, height: 80)
                case .failure:
                    Image(systemName: "xmark.circle")
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .shadow(radius: 2)
    }

    func extractID() -> String {
        // Pega o ID da URL do Pokémon
        if let id = pokemon.url.split(separator: "/").last(where: { !$0.isEmpty }) {
            return String(id)
        }
        return "1"
    }
}
