//
//  NSDate-Extention.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import Foundation
extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
