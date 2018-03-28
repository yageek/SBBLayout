//
//  SBBSlotDecorationView.swift
//  SBBLayout
//
//  Created by Yannick Heinrich on 06.11.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit

public class SBBLayoutSlotEmptyDecorationView: UICollectionReusableView {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.lightGray
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        backgroundColor = UIColor.lightGray
    }

    static let kind: String = "SBBLayoutSlotEmptyDecorationView"
}
