//
//  CollectionCycleCell.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconUrl = NSURL(string: cycleModel?.pic_url ?? "")!
            iconImg.kf.setImage(with: ImageResource(downloadURL: iconUrl as URL), placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
           
        }
    }
  

}
