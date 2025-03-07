//
//  CardGameViewModel.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score: Int = 0
    @Published var moves: Int = 0
    @Published var gameOver: Bool = false
    
    private var firstSelectedCardIndex: Int? = nil
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        let emojis = ["🐵","🎯","🐱","🦊","🐁","🦆"]

        var newCards: [Card] = []
        for emoji in emojis {
            newCards.append(Card(emoji: emoji))
            newCards.append(Card(emoji: emoji))
        }
        cards = newCards
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCardIndex = nil
        shuffleCards()
    }
    
    
    func shuffleCards() {
        for index in cards.indices {
            if !cards[index].isMatched {
                cards[index].isFaceUp = false
            }
        }
        firstSelectedCardIndex = nil
        cards.shuffle()
    }

    
    func selectCard(_ selectedCard: Card) {
        guard let selectedIndex = cards.firstIndex(where: { $0.id == selectedCard.id }) else {
            return
        }
        
        if cards[selectedIndex].isMatched || cards[selectedIndex].isFaceUp {
            return
        }
        
        if let firstIndex = firstSelectedCardIndex {
            moves += 1
            cards[selectedIndex].isFaceUp = true
            
            if cards[selectedIndex].emoji == cards[firstIndex].emoji {
                // Match found.
                cards[selectedIndex].isMatched = true
                cards[firstIndex].isMatched = true
                score += 2
                
                if cards.allSatisfy({ $0.isMatched }) {
                    gameOver = true
                }
            } else {
                if score > 0 {
                    score -= 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.cards[selectedIndex].isFaceUp = false
                    self.cards[firstIndex].isFaceUp = false
                }
            }
            firstSelectedCardIndex = nil
        } else {
            for index in cards.indices {
                if !cards[index].isMatched {
                    cards[index].isFaceUp = false
                }
            }
            firstSelectedCardIndex = selectedIndex
            cards[selectedIndex].isFaceUp = true
        }
    }
}
