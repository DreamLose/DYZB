//
//  MainViewController.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyBoardName: "Home")
        addChildVc(storyBoardName: "Live")
        addChildVc(storyBoardName: "Follow")
        addChildVc(storyBoardName: "Profile")
        

        
    }
    private func addChildVc(storyBoardName:String) {
        let childVc = UIStoryboard.init(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        addChild(childVc)
    }

   

}
