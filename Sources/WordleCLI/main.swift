import Foundation
import WordleCore

let reset = "\u{1B}[0m"

func color(_ state: LetterState) -> String {
    switch state {
    case .correct: return "\u{1B}[42;30m"   // fundo verde, letra preta
    case .present: return "\u{1B}[43;30m"   // fundo amarelo, letra preta
    case .absent:  return "\u{1B}[100;97m"  // fundo cinza, letra branca
    }
}

func row(_ guess: Guess) -> String {
    zip(guess.word, guess.states).map { letter, state in
        "\(color(state)) \(String(letter).uppercased()) \(reset)"
    }.joined(separator: " ")
}

func emptyRow(length: Int) -> String {
    Array(repeating: "\u{1B}[100m   \(reset)", count: length).joined(separator: " ")
}

func render(_ game: Game, message: String) {
    print("\u{1B}[2J\u{1B}[H", terminator: "")   // limpa a tela
    print("WORDLE PT - adivinhe a palavra de 5 letras\n")
    for guess in game.guesses {
        print("  " + row(guess))
    }
    for _ in game.guesses.count..<game.maxAttempts {
        print("  " + emptyRow(length: game.answer.count))
    }
    print("")
    if !message.isEmpty { print(message) }
}

prepareTerminal()

var game = Game(answer: Words.answers.randomElement()!)
var message = ""

while game.status == .playing {
    render(game, message: message)
    print("Tentativa \(game.guesses.count + 1)/\(game.maxAttempts): ", terminator: "")
    fflush(stdout)
    guard let line = readLine() else { break }
    do {
        try game.submit(line)
        message = ""
    } catch Game.GuessError.wrongLength {
        message = "A palavra precisa ter 5 letras."
    } catch Game.GuessError.invalidCharacters {
        message = "Use apenas letras."
    } catch {
        message = "Palpite invalido."
    }
}

render(game, message: "")
switch game.status {
case .won:
    print("Acertou em \(game.guesses.count) tentativa(s)!")
case .lost:
    print("Fim de jogo! A palavra era: \(game.answer.uppercased())")
case .playing:
    break
}