//
//  CardView.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var gameViewModel: CardGameViewModel
    let card: Card

    @State private var dragOffset: CGSize = .zero
    @State private var rotation: Angle = .zero
    
    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                CardFront(card: card)
            } else {
                CardBack()
            }
        }
        .rotation3DEffect(
            Angle.degrees(card.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .rotationEffect(rotation)
        .offset(dragOffset)
        .animation(.easeInOut(duration: 0.6), value: card.isFaceUp)
        .opacity(card.isMatched ? 0.5 : 1)
        .highPriorityGesture(
            TapGesture(count: 2)
                .onEnded {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        gameViewModel.selectCard(card)
                    }
                }
        )
        .gesture(
            TapGesture(count: 1)
                .onEnded {
                    withAnimation {
                        rotation += Angle.degrees(360)
                    }
                }
        )
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { _ in
                    withAnimation {
                        dragOffset = .zero
                    }
                }
        )
        .gesture(
            RotationGesture()
                .onChanged { angle in
                    rotation = angle
                }
                .onEnded { _ in
                    withAnimation {
                        rotation = .zero
                    }
                }
        )
    }
}

