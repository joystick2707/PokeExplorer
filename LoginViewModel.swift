import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var senha = ""
    @Published var errorMessage: String?
    @Published var usuarioLogado: Usuario?

    private let usuarioRepository: UsuarioRepositoryProtocol

    init(usuarioRepository: UsuarioRepositoryProtocol = UsuarioRepository()) {
        self.usuarioRepository = usuarioRepository
    }

    func login() {
        guard !email.isEmpty && !senha.isEmpty else {
            errorMessage = "Preencha todos os campos"
            return
        }

        if let usuario = usuarioRepository.autenticar(email: email, senha: senha) {
            usuarioLogado = usuario
            errorMessage = nil
        } else {
            errorMessage = "Email ou senha incorretos"
        }
    }
}
