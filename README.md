# Wordle PT

Wordle em português para jogar no **terminal**, escrito em Swift puro e sem dependências. Funciona no Windows, macOS e Linux.

![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-F05138?logo=swift&logoColor=white)
![Plataformas](https://img.shields.io/badge/plataformas-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey)
![Licença MIT](https://img.shields.io/badge/licen%C3%A7a-MIT-blue)
![Sem dependências](https://img.shields.io/badge/depend%C3%AAncias-0-brightgreen)

![Demonstração do jogo](docs/demo.gif)

## O jogo

Adivinhe a palavra secreta de **5 letras** em até **6 tentativas**. A cada palpite, cada letra recebe uma cor:

| Cor | Significado |
| --- | --- |
| 🟩 Verde | A letra está certa e na posição certa. |
| 🟨 Amarelo | A letra existe na palavra, mas em outra posição. |
| ⬜ Cinza | A letra não existe na palavra. |

Exemplo: se a palavra secreta for `PRAIA` e o palpite for `CASAS`, o resultado é cinza, amarelo, cinza, amarelo, cinza. O `A` existe na palavra, mas não nessas posições, e `C` e `S` não aparecem.

## Como jogar

Você precisa do [Swift](https://www.swift.org/install/) instalado (versão 5.9 ou mais nova).

```bash
git clone https://github.com/SEU_USUARIO/wordle-pt.git
cd wordle-pt
swift run wordle
```

Digite um palpite de 5 letras e aperte Enter. Maiúsculas, minúsculas e acentos são aceitos (`AÇÃO` vira `acao`).

> No Windows, use o **Windows Terminal** para ver as cores corretamente. O jogo ativa o suporte a cores ANSI do console automaticamente.

## Testes

```bash
swift test
```

Os testes cobrem a avaliação das letras (inclusive repetidas), vitória e derrota, erros de entrada, remoção de acentos e a consistência da lista de palavras.

## Como funciona

O projeto é dividido em duas partes, para manter a lógica separada da interface:

```
Sources/
  WordleCore/     biblioteca com as regras do jogo (sem nenhuma dependência de terminal)
    Evaluator.swift   compara palpite e resposta e devolve o estado de cada letra
    Game.swift        controla tentativas, vitória, derrota e validação do palpite
    Words.swift       lista de palavras e normalização de texto (acentos, maiúsculas)
  WordleCLI/      executável que desenha o jogo no terminal
    main.swift        loop do jogo, cores e mensagens
    Terminal.swift    ativa as cores ANSI no console do Windows
Tests/
  WordleCoreTests/  testes da biblioteca
```

### Letras repetidas

O detalhe mais traiçoeiro do Wordle são as letras repetidas. Se a palavra secreta tem só um `R` e você digita `RRRRR`, apenas uma letra pode ser pintada, e não todas. A função `evaluate` resolve isso em dois passos:

1. Marca todas as letras **verdes** e conta quais letras da resposta ainda sobraram.
2. Percorre o palpite de novo e marca como **amarelas** só as letras que ainda têm saldo, gastando uma unidade a cada uso.

Assim, o resultado é sempre consistente com as regras do jogo original.

## Usando só a lógica

A biblioteca `WordleCore` pode ser usada em outros projetos (um app SwiftUI, por exemplo):

```swift
import WordleCore

var game = Game(answer: "praia")

let guess = try game.submit("casas")
print(guess.states)   // [.absent, .present, .absent, .present, .absent]
print(game.status)    // .playing
```

## Próximos passos

- [ ] Dicionário de palpites válidos, para recusar palavras que não existem.
- [ ] Teclado na tela mostrando as letras já usadas.
- [ ] Palavra do dia, igual para todos os jogadores.
- [ ] Mensagens do jogo com acentuação.
- [ ] Compartilhar o resultado em emojis (🟩🟨⬜).
- [ ] Mais palavras na lista de respostas.

## Contribuindo

Issues e pull requests são bem-vindos. Antes de abrir um PR, rode `swift test` e inclua testes para o que você alterou.

## Licença

Distribuído sob a licença MIT. Veja o arquivo [LICENSE](LICENSE).
