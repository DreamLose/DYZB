//
//  CollectionBaseCell.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLab: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    var anchor : AnchorModel? {
       didSet {
           guard let anchor = anchor else {
               return
           }
           var onlineStr : String = ""
           if anchor.online >= 1000 {
               onlineStr = "\(Int(anchor.online / 10000))万在线"
           } else {
               onlineStr = "\(anchor.online)在线"
           }

           onlineBtn.setTitle(onlineStr, for: .normal)
           nickNameLab.text = anchor.nickname
           guard let incoUrl =  URL(string: anchor.vertical_src) else {
               return
           }
           iconImg.kf.setImage(with: ImageResource(downloadURL: incoUrl))
       }
   }
    
}
