//
//  Card.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var position: CGFloat = 0.0
}
