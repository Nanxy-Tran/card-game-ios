//
//  CardGame.swift
//  CardGame
//
//  Created by Thinh Tran on 05/09/2021.
//

import Foundation
import SwiftUI

struct CardGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private(set) var timeCount: TimeInterval?
    private(set) var timeAtStart: Date?
    
    private var isSelectedCardIndex: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).isOneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numberPairOfCard: Int, createContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberPairOfCard {
            let content = createContent(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating  func choose( _ card: Card) {
        if let choosenCardIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenCardIndex].isMatched,
           !cards[choosenCardIndex].isFaceUp
        
        {
            if let previousCardIndex = isSelectedCardIndex {
                if cards[previousCardIndex].content == cards[choosenCardIndex].content {
                    cards[previousCardIndex].isMatched = true
                    cards[choosenCardIndex].isMatched = true
                }
                
                cards[choosenCardIndex].isFaceUp = true
            } else {
                isSelectedCardIndex = choosenCardIndex
            }
        }
        if cards.indices.filter({cards[$0].isMatched}).count == cards.count && timeAtStart != nil {
            timeCount = Date().timeIntervalSinceReferenceDate - timeAtStart!.timeIntervalSinceReferenceDate
        }
        
        if timeAtStart == nil {
            timeAtStart = Date()
        }
     
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func restart(){
        cards.indices.forEach({
            cards[$0].isFaceUp = false
            cards[$0].isMatched = false
        })
        cards.shuffle()
        timeAtStart = nil
        timeCount = nil
    }
    
    struct Card: Identifiable {
        var isMatched = false
        var isFaceUp = false
        var content: CardContent
        var id: Int
    }
}

struct CardGame_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}

extension Array {
    var isOneAndOnly: Element? {
      if count == 1 {
         return first
      } else {
         return nil
      }
    }
}
