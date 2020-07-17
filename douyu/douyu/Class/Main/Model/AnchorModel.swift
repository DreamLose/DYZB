//
//  AnchorModel.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
   @objc var room_id : Int = 0
    //
   @objc var vertical_src : String = ""
//    判断手机直播还是电脑
   @objc var isVertical :Int = 0
   @objc var room_name : String = ""
   @objc var nickname : String = ""
   @objc var online : Int = 0
   @objc var anchor_city : String = ""
  
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
 
}
