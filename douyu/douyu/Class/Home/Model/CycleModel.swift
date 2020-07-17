//
//  CycleModel.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    @objc var title : String = ""
    @objc var pic_url :String = ""
    @objc var room : [String :NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    @objc var anchor : AnchorModel?
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
