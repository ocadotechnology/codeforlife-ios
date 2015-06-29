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
    
    init(title: String, context: String, button: String, nextLevelAction: () -> Void, playAgainAction: () -> Void) {
        super.init(
            title: title,
            subtitle: "",
            context: context,
            button: button,
            action: nextLevelAction)
        self.playAgainAction = playAgainAction
    }
    
    override func updateUI() {
        var view = PostGameMessageView.instsanceFromXib()
        view.message = self
        controller!.view = view
    }
    
}