import Foundation

public enum Words {
        /// Deixa o texto em minusculas e sem acentos.
    public static func normalize(_ text: String) -> String {
        text.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Possiveis respostas (5 letras, sem acento).
    public static let answers: [String] = [
        "almas", "amiga", "amigo", "amora", "amplo", "animo", "antes", "apoio", "areia", "aviao",
        "banco", "barco", "beijo", "besta", "bicho", "blusa", "bolsa", "braco", "bravo", "brisa", "burro",
        "cabra", "cacto", "caixa", "calor", "campo", "canto", "carro", "carta", "casal", "causa",
        "certo", "chave", "cheio", "choro", "civil", "claro", "cobra", "coisa", "colar", "comer",
        "corpo", "credo", "cruel", "curso",
        "danca", "dente", "disco", "doido", "dores",
        "entre", "etapa", "exame",
        "facil", "falar", "falso", "farol", "festa", "fogao", "folha", "forca", "forma", "forte",
        "freio", "fruta", "fundo",
        "gente", "gesto", "globo", "golpe", "gosto", "grama", "grato", "grupo",
        "humor", "ideia", "igual",
        "jogar", "jovem", "junto",
        "largo", "leite", "lenta", "letra", "limao", "linda", "longe", "lugar",
        "magia", "mamae", "manha", "massa", "meigo", "mesmo", "meses", "moeda", "molho", "morro",
        "mundo", "museu",
        "nervo", "noite", "norte", "nuvem",
        "obras", "ombro", "ontem", "ordem", "outro",
        "pacto", "pagar", "palco", "pardo", "parte", "passo", "pedra", "peixe", "perto", "piano",
        "pilha", "plano", "pouco", "praia", "prato", "prazo", "preto", "prova", "pulso",
        "queda", "quase",
        "radio", "rapaz", "razao", "reino", "rosto", "rural",
        "sabao", "sabor", "samba", "santo", "selva", "sinal", "sobre", "sonho", "sorte",
        "tanto", "tarde", "tempo", "terra", "tigre", "tinta", "tirar", "tomar", "traje", "trigo",
        "tropa", "turma",
        "unico",
        "vento", "verao", "verde", "vidro", "viola", "virar", "vozes", "vulto",
        "zebra"
    ]
}