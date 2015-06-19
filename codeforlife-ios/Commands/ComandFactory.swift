//
//  ComandFactory.swift
//  codeforlife-ios
//
//  Created by Thomas Cassany on 17/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

struct CommandFactory {
    
    
    static func loadLevelCommand(level: Int) -> LoadLevelCommand? {
        if (CodeForLifeContext.webView != nil) {
            return WebViewLoadLevelCommand(levelNumber: level, webView: CodeForLifeContext.webView!)
        }
        return nil
    }
    
}