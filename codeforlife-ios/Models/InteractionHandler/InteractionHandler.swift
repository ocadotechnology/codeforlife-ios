//
//  InteractionHandler.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 07/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import WebKit

// WKUserContentController retains its message handler causing a retain cycle,
// one of the solution to this problem is to make the actual WKScriptMessageHandler
// a weak var
class InteractionHandler: NSObject, WKScriptMessageHandler {
    
    weak var delegate: WKScriptMessageHandler?
    init(delegate: WKScriptMessageHandler?) {
        self.delegate = delegate
        super.init()
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        self.delegate?.userContentController(userContentController, didReceiveScriptMessage: message)
    }
    
}