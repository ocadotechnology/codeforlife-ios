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

class FetchBlockSetRequest : Request, RequestProtocol {
    
    weak var gameViewController: GameViewController?
    
    init( _ gameViewController: GameViewController?, _ url: String) {
        self.gameViewController = gameViewController
        super.init(
            devUrl: "https://dev-dot-decent-digit-629.appspot.com/rapidrouter/api/blocks/",
            delegate: APIRequestDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchBlockSetRequestMockDelegate())
    }
    
    override func processData(data: NSData) {
        
        let json = JSON(data: data)
        if let jsonArray = json.array {
            for block in jsonArray {
            }
        }
        
    }
    
}
