//
//  KIF+SwiftExtension.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import XCTest
import KIF

extension XCTestCase {
    
    var tester: KIFUITestActor { return tester() }
    var system: KIFSystemTestActor { return system() }
    
    private func tester(_ file : String = __FILE__, _ line : Int = __LINE__) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    private func system(_ file : String = __FILE__, _ line : Int = __LINE__) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
    
}

extension XCTestCase {
    
    struct AccessibilityIdentifier {
        static let Start = "Start"
        static let EpisodeList = "EpisodeList"
        static let LevelList = "LevelList"
        static let Spinner = "Spinner"
        static let MessageViewControllerCloseButton = "Close"
    }
    
}
