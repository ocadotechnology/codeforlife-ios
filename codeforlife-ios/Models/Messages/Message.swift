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
    var context: String?
    var action: (() -> Void)?
    var controller: MessageViewController?
    var view: MessageView
    
    init(title: String, context: String, action: () -> Void) {
        self.title = title
        self.context = context
        self.action = action
        self.view = MessageView()
    }
    
}



