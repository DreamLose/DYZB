//
//  BaseGameModel.swift
//  douyu
//
//  Created by 2020 on 2020/7/15.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
     @objc var tag_name : String = ""
     @objc var icon_url :String = ""
    override init() {
        
    }
   init(dict : [String : Any]) {
       super.init()
       setValuesForKeys(dict)
   }
   override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
   }
}
