import Foundation

public class Blockly: UIView {
    
    /**
     Nodes are always formed in pairs.
    
     Agressive Node   |   Passive Node
     -----------------+------------------
     - prev           |   - next
     - parent         |   - littleSister

     Only update Agressive nod avoid infinite recursion.
     Update prev instead of next for the following reason: For a linked list to sumbit all its relevant contents, it does not matter what previous node of some unwanted node is, since it will never be reached as long as it is not the next node of any wanted node. Hence when a unwanted node is detached from the previous node, the previous node must always set its next node to nil.
    
     Recommended Guidelines:
     1. Always update node reference before changing the position of the nodes
            - Updating position will also change littleSister and next position, which may cause littleSister and next unable to detach
     2. Avoid using willSet and didSet on both parties of a node pair
            - May cause infinite loop in recursion
     */
    
    
    weak var next: Blockly?
    weak var prev: Blockly? {
        willSet { self.prev?.updateNext(nil) }
        didSet { self.prev?.updateNext(self) }
    }
    
    
    weak var littleSister: Blockly?
    weak var bigSister: Blockly? {
        willSet { self.bigSister?.updateLittleSister(nil) }
        didSet { self.bigSister?.updateLittleSister(self) }
    }
    
    var canHaveNext   = false       /** Allow nodes to snap to its bottom, enabled by default */
    var canHavePrev   = false      /** Allow nodes to snap to its top, enabled by default */
    var canHaveBigSister = false    /** Allow nodes to snap to its right becoming a littleSister, disabled by default */
    var canHaveLittleSister  = false
    
    var lockToPrev = false
    
    static let defaultSize = CGSize(width: 100, height: 80)     /** Default size of a Blockly */
    static let defaultColor = UIColor.blackColor()              /** Default color of a Blockly */
    
    var originalSize = CGSize(width: 100, height: 80) {
        didSet { self.frame.size = originalSize }
    }
    
    /**
     After updating position, adjust positions of all the littleSisterren and nodes linked after
     */
    override public var center: CGPoint {
        didSet { updateNextAndLittleSisterPosition() }
    }
        
    var prevStickiness  : CGFloat = 30      /* Top Stickiness */
    var nextStickiness  : CGFloat = 30      /* Bottom Stickiness */
    var littleSisterStickiness : CGFloat = 30      /* Parent Stickiness */
    
    /** Returns the number of nodes linked after */
    var count: Int { return next == nil ? 0 : next!.count + 1 }
    
    /** Return the total height of all the nodes linked after including itself */
    var totalHeight: CGFloat { return next == nil ? frame.height : next!.totalHeight + frame.height }
    
    /** Return the first node of its node chain */
    var head: Blockly { return prev == nil ? self : prev!.head }
    
    /** Return the first node of its node group */
    var root: Blockly { return  (prev == nil || !lockToPrev) ? self : prev!.root }
    
    /** Blockly Builder */
    typealias BlocklyBuilderClosure = (Blockly) -> Void
    static func build(builderClosure: BlocklyBuilderClosure) -> Blockly {
        let blockly = Blockly()
        blockly.frame.size = defaultSize
        blockly.backgroundColor = defaultColor
        blockly.layer.borderWidth = 2
        blockly.layer.borderColor = UIColor.yellowColor().CGColor
        builderClosure(blockly)
        return blockly
    }
    
    private func updateNext(newNext: Blockly?) {
        let oldOrigin = head.bigSister?.frame.origin
        self.next = newNext
        let newParentHeight = max(head.totalHeight, head.bigSister == nil ? 0 : head.bigSister!.originalSize.height)
        head.bigSister?.frame.size.height = newParentHeight
        head.bigSister?.frame.origin = oldOrigin ?? head.bigSister!.frame.origin
        head.bigSister?.updateNextAndLittleSisterPosition()
    }
    
    private func updateLittleSister(newLittleSister: Blockly?) {
        let oldOrigin = self.frame.origin
        self.littleSister = newLittleSister
        self.frame.size.height = max(originalSize.height, littleSister == nil ? 0 : littleSister!.totalHeight)
        self.frame.origin = oldOrigin
        self.updateNextAndLittleSisterPosition()
    }
    
    private func updateNextAndLittleSisterPosition() {
        next?.snapToNeighbour()
        littleSister?.snapToNeighbour()
    }
    
    /** If top of the blockly is sticky and previous node is not locked, update previous node */
    func updatePrev() {
        if canHavePrev && !lockToPrev {
            let positionToFind = CGPointMake(center.x, center.y - frame.height/2 - prevStickiness)
            if let neighbour = discoverNeighbour(positionToFind) where
                neighbour.canHaveNext &&
                (neighbour.next == nil || neighbour.next == self) &&
                (prev == nil || prev == neighbour) {
                prev = neighbour
            } else {
                prev = nil
            }
        }
    }
    
    func updateNext() {
        if canHaveNext && !(next != nil && next!.lockToPrev) {
            let positionToFind = CGPointMake(center.x, center.y + frame.height/2 + nextStickiness)
            if let neighbour = discoverNeighbour(positionToFind) where
                neighbour.canHavePrev &&
                (neighbour.prev == nil || neighbour.prev == self) &&
                (next == nil || next == neighbour) {
                neighbour.prev = self
            } else {
                next = nil
            }
        }
    }
    
    func updateBigSister() {
        if canHaveBigSister {
            let positionToFind = CGPointMake(center.x - frame.width/2 - littleSisterStickiness, center.y)
            if let neighbour = discoverNeighbour(positionToFind) where
                neighbour.canHaveLittleSister &&
                (neighbour.littleSister == nil || neighbour.littleSister == self) &&
                (bigSister == nil || bigSister == neighbour) {
                bigSister = neighbour
            } else {
                bigSister = nil
            }
        }
    }
    
    /**
     Snap to the bottom of the previous node or right of the bigSister node
     Note that bigSister node has higher priority than previous node
     It also auto update the position of all the passvive nodes linked
    
     Must not call the following function or  it will cause infinite loop:
     - snapToNeighbour on prev
     - snapToNeighbour on bigSister
     */
    func snapToNeighbour() {
        if let bigSister = bigSister {
            center = CGPointMake(
                bigSister.center.x + bigSister.frame.width/2 + frame.width/2,                                 /* Stick to the right of the bigSister node */
                bigSister.center.y - bigSister.frame.height/2 + frame.height/2 /* Stick to the top */
            )
        } else if let prev = prev {
            center = CGPointMake(
                prev.center.x - prev.frame.width/2 + frame.width/2,     /* Same x */
                prev.center.y + prev.frame.height/2 + frame.height/2    /* Stick to the bottom of the previous node */
            )
        } else if let next = next {
            center = CGPointMake(
                next.center.x - next.frame.width/2 + frame.width/2,
                next.center.y - next.frame.height/2 - frame.height/2
            )
        }
        updateNextAndLittleSisterPosition()
    }
    
    private func discoverNeighbour(pos: CGPoint) -> Blockly? {
        for subview in superview!.subviews {
            if let subview = subview as? Blockly where CGRectContainsPoint(subview.frame, pos) {
                return subview
            }
        }
        return nil
    }

}
