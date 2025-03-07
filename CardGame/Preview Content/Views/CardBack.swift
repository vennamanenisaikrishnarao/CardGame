//
//  CardBack.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

struct CardBack: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
            Stripes()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .aspectRatio(2/3, contentMode: .fit)
        .shadow(color: .black.opacity(0.4), radius: 4, x: 1, y: 5)
    }
}

struct Stripes: View {
    var body: some View {
        GeometryReader { geometry in
            let stripeWidth: CGFloat = 1
            let stripeSpacing: CGFloat = 5
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                var x: CGFloat = 0
                while x < width {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                    x += stripeWidth + stripeSpacing
                }
            }
            .stroke(Color.white.opacity(0.5), lineWidth: stripeWidth)
        }
    }
}



