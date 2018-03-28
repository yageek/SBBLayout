//
//  SBBLayout.swift
//  SBBLayout
//
//  Created by Yannick Heinrich on 06.11.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit

public protocol SBBLayoutDelegate {

    func collectionView(collectionView: UICollectionView, slotSizeForStationAtRow row: Int) -> SlotSize
    func collectionView(collectionView: UICollectionView, originForStationAtRow row: Int) -> SlotPoint
}

public class SBBLayout: UICollectionViewLayout {

    var slotRow: Int = 4
    var slotColumn: Int = 4
    var slotMiminumMargin: CGFloat = 10.0
    var delegate: SBBLayoutDelegate!

    private var stationsCache: Array<UICollectionViewLayoutAttributes> = []
    private var optionsCache: Array<UICollectionViewLayoutAttributes> = []
    private var slotsCache: Array<UICollectionViewLayoutAttributes> = []

    override init() {
        super.init()

        register(SBBLayoutSlotEmptyDecorationView.self, forDecorationViewOfKind: SBBLayoutSlotEmptyDecorationView.kind)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        register(SBBLayoutSlotEmptyDecorationView.self, forDecorationViewOfKind: SBBLayoutSlotEmptyDecorationView.kind)
    }

    public override func prepare() {
        super.prepare()

        if slotsCache.isEmpty {
            computeSlotsAttribute()
        }

        if stationsCache.isEmpty {
            computeStationsAttributes()
        }
    }

    override public class var layoutAttributesClass: AnyClass {
        return SBBStationLayoutAttributes.self
    }

    public override var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }

    private func computeStationsAttributes() {

        let collectionSize = collectionView!.bounds

        let margin = slotMiminumMargin / 2.0
        let hSide = (collectionSize.width - (CGFloat(slotColumn + 1))*margin) / CGFloat(slotColumn)
        let vSide = (collectionSize.height/2.0 - (CGFloat(slotRow + 1))*margin) / CGFloat(slotRow)

        var attributes: Array<UICollectionViewLayoutAttributes> = []

        for itemRow in 0 ..< collectionView!.numberOfItems(inSection: 0) {

            let origin = delegate.collectionView(collectionView: collectionView!, originForStationAtRow: itemRow)
            let slotSize = delegate.collectionView(collectionView: collectionView!, slotSizeForStationAtRow: itemRow)

            let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: itemRow, section: 0))

            let x = CGFloat(origin.column+1)*margin + CGFloat(origin.column)*hSide
            let y = CGFloat(origin.row+1)*margin + CGFloat(origin.row)*vSide
            let width = CGFloat(slotSize.column+1)*margin + CGFloat(slotSize.column)*hSide
            let height = CGFloat(slotSize.row+1)*margin + CGFloat(slotSize.row)*vSide

            let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))

            attribute.frame = rect
            attribute.zIndex = 1
            attributes.append(attribute)
        }
        self.stationsCache = attributes
    }

    private func computeSlotsAttribute() {

        let collectionSize = collectionView!.bounds
        let hSide = (collectionSize.width - (CGFloat(slotColumn + 1))*slotMiminumMargin) / CGFloat(slotColumn)
        let vSide = (collectionSize.height/2.0 - (CGFloat(slotRow + 1))*slotMiminumMargin) / CGFloat(slotRow)

        // Display Slots
        var attributes: Array<UICollectionViewLayoutAttributes> = []

        for i in 0..<slotColumn {
            for j in 0..<slotRow {

                let x = CGFloat(i+1)*slotMiminumMargin + CGFloat(i)*hSide
                let y = CGFloat(j+1)*slotMiminumMargin + CGFloat(j)*vSide
                let rect = CGRect(x: x, y: y, width: hSide, height: vSide)

                let index = i*slotRow+j%slotColumn
                let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: SBBLayoutSlotEmptyDecorationView.kind, with: IndexPath(row: index, section: 0))

                print("Index: \(index)")
                attribute.frame = rect
                attribute.zIndex = 0

                attributes.append(attribute)
            }
        }
        slotsCache = attributes
    }

    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        // Cells

        for attribute in self.stationsCache {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }


        // Decoration View
        for attribute in self.slotsCache {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }

        return layoutAttributes
    }

}
