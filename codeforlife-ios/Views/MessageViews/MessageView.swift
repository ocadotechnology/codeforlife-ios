//
//  MessageView.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    var message: Message? {
        didSet { reloadContent() }
    }
    
    func reloadContent() {
        fatalError("Implemente reloadContent()")
    }
    
    func executeButtonAction() {
        message?.action?()
    }
    
}
