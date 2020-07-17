//
//  HomeViewController.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    private lazy var pageTitleView : PageTitle = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitle(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        let contentH = kScreenH - kStatusH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs : [UIViewController] = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmusementViewController())
        childVcs.append(FunnyViewController())
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
   
}

extension HomeViewController {
    private func setUpUI() {
        automaticallyAdjustsScrollViewInsets = false
        setUpNavigationBar()
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentView)
       }

       private func setUpNavigationBar() {
           navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
           let size = CGSize(width: 40, height: 40)
           let history = UIBarButtonItem(imageName: "image_my_history", highName: "Image_my_history_click", size: size)
           let search = UIBarButtonItem(imageName: "btn_search", highName: "btn_search_clicked", size: size)
           let qrtcode = UIBarButtonItem(imageName: "Image_scan", highName: "Image_scan_click", size: size)
           navigationItem.rightBarButtonItems = [history,search,qrtcode]
           
       }
}

extension HomeViewController : PageTitleDelegate {
    func pageTitleView(titleView: PageTitle, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceInde: sourceIndex, targetIndex: targetIndex)
    }
}
