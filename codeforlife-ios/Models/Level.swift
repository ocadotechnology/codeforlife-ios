//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation

class Level {
    
    var name: String
    var title: String
    var url: String
    var description: String?
    var hint: String?
    var origin: Node?
    var path = [Node]()
    var destinations = [Node]()
    var blocklyEnabled: Bool?
    var pythonEnabled: Bool?
    var pythonViewEnabled: Bool?
    var nextLevel: Level?
    var webViewUrl: String

    init(url: String, name: String, title: String) {
        self.url = url
        self.title = title
        self.name = name
        self.webViewUrl = kCFLDomain + kCFLRapidRouter + name + "/?mode=ios"
    }

}
