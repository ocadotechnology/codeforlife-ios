//
//  LevelTest.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 02/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import XCTest

class LevelTest: XCTestCase {

    func test1Init() {
        var level =
        Level(url: "url", name: "name", title: "title")
        XCTAssertEqual(level.name, "name", "Name not match")
        XCTAssertEqual(level.title, "title", "Title not match")
        XCTAssertEqual(level.url, "url", "Url not match")
        XCTAssertEqual(level.webViewUrl, kCFLDomain + kCFLRapidRouter + "name" + "/?mode=ios", "WebUrl not match")
    }

}
