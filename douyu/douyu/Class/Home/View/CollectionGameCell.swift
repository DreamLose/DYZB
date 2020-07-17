//
//  CollectionGameCell.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    var gameModel :BaseGameModel? {
       
        didSet {
            titleLable.text = gameModel?.tag_name
            guard let iconUrl = URL(string: gameModel?.icon_url ?? "") else {
                iconImg.image = UIImage(named: "home_more_btn")
                return
            }
            iconImg.kf.setImage(with: ImageResource(downloadURL: iconUrl), placeholder: UIImage(named: "home_more_btn"))
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
