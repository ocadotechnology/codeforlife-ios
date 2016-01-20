//
//  BlocklyCores.swift
//  Pods
//
//  Created by Joey Chan on 01/09/2015.
//
//

import Foundation

public class Blocklys {
    
    private var list: [Blockly]
    
    public init() {
        self.list = [Blockly]()
    }
    
    public var count : Int {
        return list.count
    }
    
    public func append(blocklyCore: Blockly) {
        if !contains(blocklyCore) {
            list.append(blocklyCore)
        }
    }
    
    public func appendIfNotNil(blocklyCore: Blockly?) {
        if let blocklyCore = blocklyCore {
            append(blocklyCore)
        }
    }
    
    public func contains(blocklyCoreToBeFound: Blockly) -> Bool {
        for blocklyCore in list {
            if blocklyCore === blocklyCoreToBeFound {
                return true
            }
        }
        return false
    }
    
    public func remove(blocklyCoreToBeRemoved: Blockly?) {
        if let blocklyCoreToBeRemoved = blocklyCoreToBeRemoved {
            for (index, blocklyCore) in list.enumerate() {
                if blocklyCore === blocklyCoreToBeRemoved {
                    list.removeAtIndex(index)
                }
            }
        }
    }
    
    public func foreach(closure: (Blockly) -> Void) {
        for blocklyCore in list {
            closure(blocklyCore)
        }
    }
    
    public func getItemAtIndex(index: Int) -> Blockly? {
        if index < list.count {
            return list[index]
        }
        return nil
    }
    
}