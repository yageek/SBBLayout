//
//  SBBStationLayoutAttributes.swift
//  SBBLayout
//
//  Created by Yannick Heinrich on 06.11.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit

public struct SlotSize: Equatable {
    let row: Int
    let column: Int

    public static func==(lhs: SlotSize, rhs: SlotSize) -> Bool {
        return lhs.row == rhs.row && rhs.column == lhs.column
    }
}

public typealias SlotPoint = SlotSize

class SBBStationLayoutAttributes: UICollectionViewLayoutAttributes {

    var slotSize = SlotSize(row: 1, column: 1)
    var origin = SlotPoint(row: 0, column: 0)

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! SBBStationLayoutAttributes
        copy.slotSize = slotSize
        copy.origin = origin

        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? SBBStationLayoutAttributes {
            if attributes.slotSize == slotSize && attributes.origin == origin {
                return super.isEqual(object)
            }
        }
        return false
    }
}
