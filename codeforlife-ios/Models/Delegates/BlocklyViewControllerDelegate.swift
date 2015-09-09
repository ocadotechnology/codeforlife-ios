//
//  BlocklyViewControllerDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol BlocklyViewControllerDelegate {
    func submitBlocks(script: String, completion: (() -> Void)?)
}
