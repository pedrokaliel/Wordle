public struct Guess: Equatable {
    public let word: String
    public let states: [LetterState]
}

public struct Game {
    public enum Status: Equatable { case playing, won, lost }
    public enum GuessError: Error, Equatable { case wrongLength, invalidCharacters, gameOver }

    public let answer: String
    public let maxAttempts: Int
    public private(set) var guesses: [Guess] = []

    public init(answer: String, maxAttempts: Int = 6) {
        self.answer = Words.normalize(answer)
        self.maxAttempts = maxAttempts
    }

    public var status: Status {
        if guesses.last?.word == answer { return .won }
        if guesses.count >= maxAttempts { return .lost }
        return .playing
    }

    @discardableResult
    public mutating func submit(_ input: String) throws -> Guess {
        guard status == .playing else { throw GuessError.gameOver }
        let word = Words.normalize(input)
        guard word.count == answer.count else { throw GuessError.wrongLength }
        guard word.allSatisfy({ $0 >= "a" && $0 <= "z" }) else {
            throw GuessError.invalidCharacters
        }
        let guess = Guess(word: word, states: evaluate(guess: word, answer: answer))
        guesses.append(guess)
        return guess
    }
}