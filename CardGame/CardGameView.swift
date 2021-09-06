//
//  ContentView.swift
//  CardGame
//
//  Created by Thinh Tran on 03/09/2021.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var game: CardGameplay
    var gridColumns : [GridItem] = Array(repeating: .init(), count: 4)
    
    var body: some View {
        ZStack {
           
                VStack {
                    GeometryReader {
                        geometry in
                        AspectVGrid(items: game.cards, aspectRatio: 2/3, size: geometry.size) { card in
                            CardView(card: card).onTapGesture {
                                withAnimation(.linear(duration: 0.2)) {
                                    game.choose(card: card)
                                }
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                game.shuffle()
                            }
                        }, label: {
                            Text("Shuffle cards")
                            Image(systemName: "shuffle.circle").foregroundColor(.blue).font(.title)
                        })
                    }.padding()
                }.padding()
        
            if game.gameOver {
                RoundedRectangle(cornerRadius: 15)
                    .fill()
                    .foregroundColor(.yellow)
                    .frame(width: 200, height: 150, alignment: .center)
                
                VStack {
                    Text(" 🏆 Bạn là nhất ! 🏆").font(.title3)
                    if game.timeCount != nil {
                        Text(String(format: "Thời gian: %.2f", TimeInterval(game.timeCount!)))
                    }
                    
                    Button("Chơi lại", action: {
                            game.restart()
                        })
                        .padding()
                        .foregroundColor(.blue)
                }
            }
                
            
        }
    }
}


struct CardView: View {
    var card: CardGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                
                Text(card.content)
                    .font(.largeTitle)
                
                if  card.isFaceUp {
                    shape
                        .strokeBorder(lineWidth: 2, antialiased: true)
                        .foregroundColor(.yellow)
                    shape.opacity(0)
                    
                } else if card.isMatched {
                    shape
                        .fill()
                        .foregroundColor(.white)
                } else {
                    shape
                        .fill()
                        .foregroundColor(.yellow)
                }
            }.rotation3DEffect(Angle.degrees(card.isFaceUp ? 180: 0), axis: (0, 1, 0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = CardGameplay()
        CardGameView(game: game)
    }
}
