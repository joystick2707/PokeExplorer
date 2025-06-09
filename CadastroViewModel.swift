import Foundation

@MainActor
class CadastroViewModel: ObservableObject {
    @Published var nomeDeUsuario = ""
    @Published var email = ""
    @Published var senha = ""
    @Published var confirmacaoSenha = ""
    @Published var errorMessage: String?
    @Published var sucessoCadastro = false

    private let usuarioRepository: UsuarioRepositoryProtocol

    init(usuarioRepository: UsuarioRepositoryProtocol = UsuarioRepository()) {
        self.usuarioRepository = usuarioRepository
    }

    func cadastrar() {
        guard senha == confirmacaoSenha else {
            errorMessage = "As senhas não coincidem"
            return
        }

        guard !nomeDeUsuario.isEmpty && !email.isEmpty && !senha.isEmpty else {
            errorMessage = "Preencha todos os campos"
            return
        }

        let novoUsuario = Usuario(id: UUID(), nomeDeUsuario: nomeDeUsuario, email: email, senha: senha)
        let sucesso = usuarioRepository.salvar(usuario: novoUsuario)

        if sucesso {
            sucessoCadastro = true
            errorMessage = nil
        } else {
            errorMessage = "Erro ao criar conta"
        }
    }
}
