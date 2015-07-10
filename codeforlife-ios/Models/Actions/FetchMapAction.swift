//
//  File.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchMapAction : Action {
    
    var viewController: GameMapViewController
    
    init( _ viewController: GameMapViewController, _ url: String) {
        self.viewController = viewController
        super.init(
            devUrl: url,
            delegate: APIActionDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchMapActionMockDelegate())
    }
    
    override func processData(data: NSData) {
        
        let json = JSON(data: data)
        //TODO
        
    }

    
}