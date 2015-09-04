//
//  BaseAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import Alamofire

protocol Request {
    
    var url: String {get}
    var method: Alamofire.Method {get}
    var params: [String: String] {get set}
    var mode: Mode {get set}
    
    func execute(callback: (() -> Void)?)
    
    /* Implement this function to handle the data processing after fetching data */
    func processData(data: NSData)
}
