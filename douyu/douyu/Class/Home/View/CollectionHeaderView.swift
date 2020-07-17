//
//  CollectionHeaderView.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var moreBtn: UIButton!
    var group :anchorGroupModel? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImg.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
extension CollectionHeaderView {
    class func headerView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
