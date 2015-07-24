//
//  StringExtension.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

extension String {
    
    func removedHtmlTag() -> String{
    return self
        .stringByReplacingOccurrencesOfString("<br>", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
        .stringByReplacingOccurrencesOfString("<b>", withString: "<", options: NSStringCompareOptions.LiteralSearch, range: nil)
        .stringByReplacingOccurrencesOfString("</b>", withString: ">", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
}