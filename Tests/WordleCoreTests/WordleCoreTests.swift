import XCTest
import WordleCore

final class WordleCoreTests: XCTestCase {
    func testTudoCerto() {
        XCTAssertEqual(evaluate(guess: "praia", answer: "praia"),
                       [.correct, .correct, .correct, .correct, .correct])
    }

    func testPresentesEAusentes() {
        // resposta PRAIA, palpite CASAS
        XCTAssertEqual(evaluate(guess: "casas", answer: "praia"),
                       [.absent, .present, .absent, .present, .absent])
    }

    func testLetrasRepetidasNoPalpite() {
        // so existem dois A em PRAIA, ambos ja estao no lugar certo
        XCTAssertEqual(evaluate(guess: "aaaaa", answer: "praia"),
                       [.absent, .absent, .correct, .absent, .correct])
        XCTAssertEqual(evaluate(guess: "rrrrr", answer: "carro"),
                       [.absent, .absent, .correct, .correct, .absent])
    }

    func testNormalizaAcentos() {
        XCTAssertEqual(Words.normalize("A\u{E7}\u{E3}O"), "acao")
    }

    func testVitoria() throws {
        var game = Game(answer: "praia")
        try game.submit("PRAIA")
        XCTAssertEqual(game.status, .won)
    }

    func testDerrota() throws {
        var game = Game(answer: "praia", maxAttempts: 2)
        try game.submit("carro")
        try game.submit("barco")
        XCTAssertEqual(game.status, .lost)
        XCTAssertThrowsError(try game.submit("praia"))
    }

    func testErrosDeEntrada() {
        var game = Game(answer: "praia")
        XCTAssertThrowsError(try game.submit("abc")) {
            XCTAssertEqual($0 as? Game.GuessError, .wrongLength)
        }
        XCTAssertThrowsError(try game.submit("ab1de")) {
            XCTAssertEqual($0 as? Game.GuessError, .invalidCharacters)
        }
    }

    func testListaDePalavras() {
        for word in Words.answers {
            XCTAssertEqual(word.count, 5, word)
            XCTAssertTrue(word.allSatisfy { $0 >= "a" && $0 <= "z" }, word)
        }
        XCTAssertEqual(Set(Words.answers).count, Words.answers.count)
    }
}