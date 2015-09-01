//
//  BlocklyUIDelegate.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

protocol BlocklyUIDelegate {
    func inputDidChange()
    func nextConnectionDidChange()
    func previousConnectionDidChange()
    func outputConnectionDidChange()
    func outputTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?)
    func previousTargetConnectionDidChange(oldTargetConnection: Connection?, orphanConnection: Connection?, newTargetConnection: Connection?)
    func nextTargetConnectionDidChange()
}