//
//  PreGameMessage.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class PreGameMessage: Message {
    
    init(title: String, context: String, button: String, action: () -> Void) {
        super.init(
            title: title,
            subtitle: "",
            context: context,
            button: button,
            action: action)
    }
    
    override func updateUI() {
        var view = PreGameMessageView.instsanceFromXib()
        view.message = self
        controller!.view = view
    }

    
}