//
//  BaseActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestDelegate {

    func execute(processData: (NSData -> Void), callback: () -> Void)
    
}

class ErrorRequestDelegate : RequestDelegate {
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        fatalError("Error")
    }
    
}