//
//  ControlPanel.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

struct ControlPanel: View {
    @ObservedObject var gameViewModel: CardGameViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Score: \(gameViewModel.score)")
                    .font(.headline)
                Spacer()
                Text("Moves: \(gameViewModel.moves)")
                    .font(.headline)
            }
            
            HStack {
                Button(action: {
                    withAnimation(.spring()) {
                        gameViewModel.startNewGame()
                    }
                }) {
                    Text("New Game")
                }
                Spacer()
                Button(action: {
                    withAnimation(.spring()) {
                        gameViewModel.shuffleCards()
                    }
                }) {
                    Text("Shuffle")
                }
            }
            
            if gameViewModel.gameOver {
                Text("Game Over!")
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
