//
//  CardGameApp.swift
//  CardGame
//
//  Created by Thinh Tran on 03/09/2021.
//

import SwiftUI

@main
struct CardGameApp: App {
    let game = CardGameplay()
    
    var body: some Scene {
        WindowGroup {
            CardGameView(game: game)
        }
    }
}
