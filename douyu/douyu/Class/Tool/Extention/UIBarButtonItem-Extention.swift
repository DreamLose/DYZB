//
//  UIBarButtonItem-Extention.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    convenience init(imageName:String,highName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highName != "" {
            btn.setImage(UIImage(named: highName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
        
        
    }
}

