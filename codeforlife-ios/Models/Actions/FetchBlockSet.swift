//
//  FetchBlockSet.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 10/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchBlockSet : Action {
    
    var gameViewController: GameViewController
    
    init( _ gameViewController: GameViewController, _ url: String? = nil) {
        self.gameViewController = gameViewController
        super.init(
            devUrl: url ?? gameViewController.level!.url,
            delegate: APIActionDelegate(url: url ?? gameViewController.level!.url, method: Alamofire.Method.GET),
            mockDelegate: FetchBlockSetMockDelegate())
    }
    
    override func processData(data: NSData) {
        
        let json = JSON(data: data)
        //TODO
        
    }
    
}
