//
//  BaseNavController.swift
//  douyu
//
//  Created by 2020 on 2020/7/15.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.isEnabled = false
        guard let systemGes = interactivePopGestureRecognizer else {
            return
        }
    
        guard let gesView = systemGes.view else {
            return
        }
        
         //3.获取target／action
                //3.1利用运行时机制查看所有的属性名称
    //        var count : UInt32 = 0
    //        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
    //        for i in 0..<count {
    //            let ivar = ivars[Int(i)]
    //            let name = ivar_getName(ivar)
    //            print(String(cString: name!))
    //        }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let tarObjc = targets?.first else {
            return
        }
        guard let tar = tarObjc.value(forKey: "target") else {return}
        
//        guard let action = tarObjc.value(forKey: "action") as? Selector else {return}
        //
        let action = Selector(("handleNavigationTransition:"))
       
        //创建自己手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(tar, action: action)
       
//        var count :UInt32 = 0
//         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
//
        
        
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
        
    }
 
}
