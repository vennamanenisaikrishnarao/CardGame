//
//  ContentView.swift
//  CardGame
//
//  Created by Vennamaneni, Sai Krishna on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameViewModel = CardGameViewModel()
    @State private var deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            ZStack {
                Color(red: 0.88, green: 0.93, blue: 1.0)
                    .ignoresSafeArea()
                
                if isLandscape {
                    HStack(spacing: 0) {
                        createCardGrid(screenSize: geometry.size, isLandscape: true)
                        ControlPanel(gameViewModel: gameViewModel)
                            .frame(width: geometry.size.width * 0.4)
                    }
                } else {
                    
                    VStack() {
                        createCardGrid(screenSize: geometry.size, isLandscape: false)
                            .padding(.top, 130)
                        
                        ControlPanel(gameViewModel: gameViewModel)
                            .padding(.bottom, 100)
                        
                    }
                }
            }
            .onChange(of: geometry.size) {
                withAnimation(.spring()) {
                    deviceOrientation = UIDevice.current.orientation
                }
            }
        }
    }
    
    private func createCardGrid(screenSize: CGSize, isLandscape: Bool) -> some View {

        let portraitCardWidth: CGFloat = 90
        let landscapeCardWidth: CGFloat = 80
        
        let columnsCount = 4
        
        let spacing: CGFloat = 8
        let horizontalPadding: CGFloat = 12
        
        
        let cardWidth = isLandscape ? landscapeCardWidth : portraitCardWidth
        let cardHeight = cardWidth * 1.5
        
        
        let columns = Array(repeating: GridItem(.fixed(cardWidth), spacing: spacing), count: columnsCount)
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(gameViewModel.cards) { card in
                    CardView(gameViewModel: gameViewModel, card: card)
                        .frame(width: cardWidth, height: cardHeight)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 10)
        }
    }
}

#Preview {
    ContentView()
}

