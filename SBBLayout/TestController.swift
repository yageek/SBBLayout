//
//  TestController.swift
//  SBBLayout
//
//  Created by Yannick Heinrich on 06.11.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit

private let stationReusableIdentifier = "StationReusableView"
private let optionsReusableIdentifier = "OptionReusableView"
private let slotReusableView = "SlotReusableView"

class TestController: UICollectionViewController, SBBLayoutDelegate {

    @IBOutlet weak var layout: SBBLayout!
    override func viewDidLoad() {
        super.viewDidLoad()

        layout.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, slotSizeForStationAtRow row: Int) -> SlotSize {
        if row == 0 {
            return SlotSize(row: 1, column: 2)
        } else {
            return SlotSize(row: 1, column: 1)
        }
    }
    func collectionView(collectionView: UICollectionView, originForStationAtRow row: Int) -> SlotPoint {
        if row == 0 {
            return SlotPoint(row: 0, column: 0)
        } else {
            return SlotPoint(row: 1, column: 1)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: stationReusableIdentifier, for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: optionsReusableIdentifier, for: indexPath)
        }

    }

}
