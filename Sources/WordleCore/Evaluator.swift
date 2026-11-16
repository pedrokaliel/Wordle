public enum LetterState: Equatable {
    case correct   // verde: letra certa no lugar certo
    case present   // amarelo: letra existe, mas em outro lugar
    case absent    // cinza: letra nao existe (ou ja foi usada)
}

/// Compara o palpite com a resposta, tratando letras repetidas.
public func evaluate(guess: String, answer: String) -> [LetterState] {
    let g = Array(guess)
    let a = Array(answer)
    guard g.count == a.count else { return [] }

    var result = Array(repeating: LetterState.absent, count: g.count)
    var remaining: [Character: Int] = [:]

    // Passo 1: marca os verdes e conta as letras da resposta que sobraram
    for i in 0..<g.count {
        if g[i] == a[i] {
            result[i] = .correct
        } else {
            remaining[a[i], default: 0] += 1
        }
    }

    // Passo 2: marca os amarelos, gastando as letras que sobraram
    for i in 0..<g.count where result[i] != .correct {
        if let n = remaining[g[i]], n > 0 {
            result[i] = .present
            remaining[g[i]] = n - 1
        }
    }
    return result
}