//
//  BlocklyCores.swift
//  Pods
//
//  Created by Joey Chan on 01/09/2015.
//
//

import Foundation

public class BlocklyCores {
    
    private var list: [BlocklyCore]
    
    public init() {
        self.list = [BlocklyCore]()
    }
    
    public var count : Int {
        return list.count
    }
    
    public func append(blocklyCore: BlocklyCore) {
        if !contains(blocklyCore) {
            list.append(blocklyCore)
        }
    }
    
    public func contains(blocklyCoreToBeFound: BlocklyCore) -> Bool {
        for blocklyCore in list {
            if blocklyCore === blocklyCoreToBeFound {
                return true
            }
        }
        return false
    }
    
    public func remove(blocklyCoreToBeRemoved: BlocklyCore) {
        for (index, blocklyCore) in enumerate(list) {
            if blocklyCore === blocklyCoreToBeRemoved {
                list.removeAtIndex(index)
            }
        }
    }
    
    public func foreach(closure: (BlocklyCore) -> Void) {
        for blocklyCore in list {
            closure(blocklyCore)
        }
    }
    
    public func getItemAtIndex(index: Int) -> BlocklyCore? {
        if index < list.count {
            return list[index]
        }
        return nil
    }
    
}