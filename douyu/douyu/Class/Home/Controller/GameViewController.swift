//
//  GameViewController.swift
//  douyu
//
//  Created by 2020 on 2020/7/15.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
private let kGameCellId : String = "kGameCellId"
private let kNormalHeadViewId : String = "kNormalHeadViewId"
private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let headerH : CGFloat = 50
private let kGameH : CGFloat = 90
class GameViewController: UIViewController {
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var recommendV : RecommendGameView = {
        let recommendv = RecommendGameView.recommendGameView()
        recommendv.frame = CGRect(x: 0, y: -kGameH, width: kScreenW, height: kGameH)
        return recommendv
    }()
    fileprivate lazy var headerView : CollectionHeaderView = {
        let heaerView = CollectionHeaderView.headerView()
        heaerView.frame = CGRect(x: 0, y: -(headerH + kGameH), width: kScreenW, height: headerH)
        heaerView.titleLabel.text = "常用"
        heaerView.iconImg.image = UIImage(named: "Img_orange")
        heaerView.moreBtn.isHidden = true
        return heaerView
    }()
    fileprivate lazy var collection : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerH)
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        collection.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kNormalHeadViewId)
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
    }
}
extension GameViewController {
    func setUpUI(){
        view.addSubview(collection)
        collection.addSubview(headerView)
        collection.addSubview(recommendV)
        collection.contentInset = UIEdgeInsets(top: headerH + kGameH, left: 0, bottom: 0, right: 0)
    }
}

extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameDate {
            self.collection.reloadData()
            self.recommendV.groups = Array(self.gameVM.gameModels[0..<10])
        }
    }
}

extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameCell
        let gameModel = gameVM.gameModels[indexPath.item]
        cell.gameModel = gameModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeadViewId, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.iconImg.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
        
    }
    
    
}
