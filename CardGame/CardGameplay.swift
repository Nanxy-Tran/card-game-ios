//
//  CardGameplay.swift
//  CardGame
//
//  Created by Thinh Tran on 05/09/2021.
//

import SwiftUI

class CardGameplay: ObservableObject {
    static let emojis = ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂", "🤬","🥶","🤢","🤠","😷","🤕","😱","😜", "⚽️","🏀","🏈","⚾️","🎾","🏐","🎱"]
    
    static func createGameplay() -> CardGame<String> {
        CardGame<String>(numberPairOfCard: 10, createContent: {
                   emojiIndex in CardGameplay.emojis[emojiIndex]
               })
    }
    
    @Published private(set) var gameModel = createGameplay()
    
    var cards: Array<CardGame<String>.Card> {
        return gameModel.cards
    }
    
    var gameOver: Bool {
        let cards = gameModel.cards
        return cards.indices.filter({cards[$0].isMatched}).count == cards.count
    }
    
    var timeCount: TimeInterval? {
        return gameModel.timeCount
    }
    
       
    // MARK : Intent(s)
    
    func choose(card : CardGame<String>.Card) {
        gameModel.choose(card)
    }
    
    func shuffle() {
        gameModel.shuffle()
    }
    
    func restart() {
        gameModel.restart()
    }
        
}
