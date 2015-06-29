//
//  PostGameMessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class PostGameMessage: Message {
    
    var playAgainAction: (() -> Void)?
    
    init(title: String, context: String, nextLevelAction: () -> Void, playAgainAction: () -> Void) {
        super.init(title: title, context: context, action: nextLevelAction)
        self.playAgainAction = playAgainAction
        self.view = PostGameMessageView.instsanceFromXib(self)
    }

    
}