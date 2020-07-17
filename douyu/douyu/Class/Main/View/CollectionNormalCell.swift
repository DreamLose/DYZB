//
//  CollectionNormalCell.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLab: UILabel!
    

    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLab.text = anchor?.room_name
        }
            
    }
}
