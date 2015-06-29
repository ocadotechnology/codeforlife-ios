//
//  HelpMessage.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class HelpMessage: Message {
    
    init(context: String, action: () -> Void) {
        super.init(title: "Help", subtitle: "", context: context, button: "OK", action: action)
    }
    
    override func updateUI() {
        var view = HelpMessageView.instsanceFromXib()
        view.message = self
        controller!.view = view
    }
    
}