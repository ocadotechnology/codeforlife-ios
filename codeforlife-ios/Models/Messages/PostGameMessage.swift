//
//  PostGameMessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class PostGameMessage: Message {
    
    var pathScore: Float
    var instrScore: Float
    var maxPathScore: Int
    var maxInstrScore: Int
    
    var playAgainAction: (() -> Void)?
    
    init(context: String, pathScore: Float, maxPathScore: Int, instrScore: Float, maxInstrScore: Int, nextLevelAction: () -> Void, playAgainAction: () -> Void) {
        self.pathScore = pathScore
        self.maxPathScore = maxPathScore
        self.instrScore = instrScore
        self.maxInstrScore = maxInstrScore
        super.init(title: "You win!", context: context, action: nextLevelAction)
        self.playAgainAction = playAgainAction
        self.view = PostGameMessageView.instsanceFromXib(self)
    }

    
}