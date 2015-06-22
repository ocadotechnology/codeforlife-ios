//
//  BaseActionDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire

protocol ActionDelegate {

    func execute(request : Request, processData: (NSData -> Void), callback: () -> Void)
    
}
