//
//  CardFront.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

struct CardFront: View {
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 3)
            Text(card.emoji)
                .font(.largeTitle)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .shadow(color: .black.opacity(0.4), radius: 4, x: 1, y: 5)
    }
}



