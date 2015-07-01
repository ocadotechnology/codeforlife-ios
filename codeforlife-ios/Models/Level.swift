//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation

class Level {
    
    var name: String
    var title: String
    var url: String
    var nextLevel: Level?
    var webViewUrl: String

    init(name: String, title: String, url: String){
        self.title = title
        self.url = url
        self.name = name
        self.webViewUrl = kCFLDomain + kCFLRapidRouter + self.name
    }

}
