//
//  GameMessage.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class GameMessage: Message {

    init(title: String, context: String, action: () -> Void = {}) {
        super.init(title: title, subtitle: "", context: context, button: "Play", action: action)
    }
    
}