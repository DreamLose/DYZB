 //
//  RecommendCycleView.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

 private let cycleCellID : String = "cycleCellID"
class RecommendCycleView: UIView {
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            self.collectionView.reloadData()
            //设置pagecontrol
            self.pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置子控件不随父控拉伸
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCellID)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cycleCellID)
       
         
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
       layout.itemSize = collectionView.bounds.size
     
    }
 
}

 extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
 }
 extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCellID, for: indexPath) as! CollectionCycleCell
        let cycleModel = cycleModels![indexPath.item % (cycleModels?.count ?? 1)]
        cell.cycleModel = cycleModel
       
        return cell
        
    }
    
   
 }
 extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetx = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetx / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
 }

 extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc private func scrollToNext() {
        let currentOffx = collectionView.contentOffset.x
        let offx = currentOffx + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offx, y: 0), animated: true)
        
        
    }
 }
