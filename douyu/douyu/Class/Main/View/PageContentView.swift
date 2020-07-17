//
//  PageContentView.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}
private let collectionCellId : String = "collectionCellId"
class PageContentView: UIView {
    private var startOffSetX : CGFloat = 0
    private var childVcs : [UIViewController]
    private weak var parentVc : UIViewController?
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    private lazy var collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        return collectionView
    }()
    init(frame: CGRect,childVcs:[UIViewController],parentVc:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    private func setUpUI() {
        for childVc in childVcs {
            parentVc?.addChild(childVc)
            
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
    
    
}
extension PageContentView : UICollectionViewDelegate {
  
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffSetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
        var progress : CGFloat = 0
        var soucreIndex : Int = 0
        var targetIndex : Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let srollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffSetX { //左滑
            progress = currentOffsetX / srollViewW - floor(currentOffsetX / srollViewW)
            soucreIndex = Int(currentOffsetX / srollViewW)
            targetIndex = soucreIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffSetX == srollViewW {
                progress = 1
                targetIndex = soucreIndex
            }
        } else {
            progress = 1 - (currentOffsetX / srollViewW - floor(currentOffsetX / srollViewW))
            targetIndex = Int(currentOffsetX / srollViewW)
            soucreIndex = targetIndex + 1
            if soucreIndex >= childVcs.count {
                soucreIndex = childVcs.count - 1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: soucreIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        isForbidScrollDelegate = true
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}
