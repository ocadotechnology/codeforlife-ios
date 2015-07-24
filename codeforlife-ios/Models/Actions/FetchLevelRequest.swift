//
//  FetchLevelAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class FetchLevelRequest : Request, RequestProtocol
{
    
    unowned var viewController: GameViewController
    
    init( _ viewController: GameViewController, _ url: String? = nil) {
        self.viewController = viewController
        super.init(
            devUrl: url ?? viewController.level!.url,
            delegate: APIRequestDelegate(url: viewController.level!.url, method: Alamofire.Method.GET),
            mockDelegate: FetchLevelRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
            
        let json = JSON(data: data)
        if let description = json["description"].string,
            hint = json["hint"].string,
            blocklyEnabled = json["blocklyEnabled"].bool,
            pythonEnabled = json["pythonEnabled"].bool,
            pythonViewEnabled = json["pythonViewEnabled"].bool,
            blockSetUrl = json["levelblock_set"].string,
            mapUrl = json["map"].string,
            level = viewController.level {
                
                var processedDescription = description.removedHtmlTag()
                var processedHint = hint.removedHtmlTag()
                
                level.description = processedDescription
                level.hint = processedHint
                level.blocklyEnabled = blocklyEnabled
                level.pythonViewEnabled = pythonViewEnabled
                level.pythonEnabled = pythonEnabled
                level.blockSetUrl = blockSetUrl
                level.mapUrl = mapUrl
                
            }
    }
    
//    deinit { println("FetchLevelAction is being deallocated") }
    
}