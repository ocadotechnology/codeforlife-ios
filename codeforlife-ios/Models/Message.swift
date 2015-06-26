//
//  Message.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Message {
    
    var title: String?
    var subtitle: String?
    var context: String?
    var buttonText: String?
    var action: (() -> Void)?
    
    init(title: String, subtitle: String, context: String, button: String, action: () -> Void = {}) {
        self.title = title
        self.subtitle = subtitle
        self.context = context
        self.buttonText = button
        self.action = action
    }
    
}



