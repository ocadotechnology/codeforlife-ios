//
//  ErrorMessage.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class FailMessage: Message {
    
    override init(title: String, context: String, action: () -> Void) {
        super.init(title: title, context: context, action: action)
        self.view = ErrorMessageView.instsanceFromXib(self)
    }
    
}