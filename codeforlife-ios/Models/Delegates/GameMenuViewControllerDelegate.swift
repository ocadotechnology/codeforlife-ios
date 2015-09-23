//
//  GameMenuViewControllerDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 09/09/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

public protocol GameMenuViewControllerDelegate: class {
    func setBlocklyEditable(editable: Bool, completion: (() -> Void)?)
    func stop(completion: (() -> Void)?)
    func clear(completion: (() -> Void)?)
    func play(completion: (() -> Void)?)
    func help(completion: (() -> Void)?)
    func runAnimation(runAnimation: Bool, completion: (() -> Void)?)
    func stepAnimation(step: Bool, completion: (() -> Void)?)
}
