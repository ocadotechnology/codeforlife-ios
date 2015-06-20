//
//  BaseActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol ActionDelegateProtocol {
    func execute(request : NSMutableURLRequest, processData: (NSData -> Void))
}

class ActionDelegate : ActionDelegateProtocol {

    func execute(request : NSMutableURLRequest, processData: (NSData -> Void)) {
        NSException(name: "Implement execute() for \(self)", reason: "" , userInfo: nil).raise()
    }
    
}
