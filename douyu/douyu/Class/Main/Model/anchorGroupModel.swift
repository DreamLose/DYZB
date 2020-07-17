//
//  anchorGroupModel.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class anchorGroupModel: BaseGameModel {
    @objc var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dic in room_list {
                achors.append(AnchorModel(dict: dic))
            }
        }
    }
   @objc var icon_name : String = "home_header_normal"
    lazy var achors : [AnchorModel] = [AnchorModel]()

}
