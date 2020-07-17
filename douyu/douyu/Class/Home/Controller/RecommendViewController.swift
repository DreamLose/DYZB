//
//  RecommendViewController.swift
//  douyu
//
//  Created by 2020 on 2020/7/13.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
private let kItemMarin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMarin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderH : CGFloat = 50
private let kCycleH : CGFloat = kScreenW * 3 / 8
private let kGameH : CGFloat = 90
private let kNormalCellId : String = "kNormalCellId"
private let kNormalHeadViewId : String = "kNormalHeadViewId"
private let kPrettyCellId : String = "kPrettyCellId"


class RecommendViewController: UIViewController {
    private lazy var recommendGame : RecommendGameView = {
        let recommendGame = RecommendGameView.recommendGameView()
        recommendGame.frame = CGRect(x: 0, y: -kGameH, width: kScreenW, height: kGameH)
        return recommendGame
    }()
    private lazy var recommendCycle :RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleH + kGameH), width: kScreenW, height: kCycleH)
        return cycleView
    }()
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMarin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMarin, bottom: 0, right: kItemMarin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
         collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kNormalHeadViewId)
        
        return collectionView

    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        //请求数据
       
        loadData()
    }
    
    
}

extension RecommendViewController {
    private func setUpUI() {
        view.addSubview(collectionView)
        collectionView.addSubview(recommendCycle)
        collectionView.addSubview(recommendGame)
        collectionView.contentInset = UIEdgeInsets(top: kCycleH + kGameH, left: 0, bottom: 0, right: 0)
    }
}
extension RecommendViewController {
    private func loadData() {
        recommendVM.requestDate {
            self.collectionView.reloadData()
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroups = anchorGroupModel()
            moreGroups.tag_name = "更多"
            groups.append(moreGroups)
            self.recommendGame.groups = groups
        }
        recommendVM.requestCycle {
            self.recommendCycle.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.achors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.achors[indexPath.item]
        
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
            
        }else {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
            
        }
        cell.anchor = anchor
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeadViewId, for: indexPath) as! CollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}

extension RecommendViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let archor = recommendVM.anchorGroups[indexPath.section].achors[indexPath.item]
        archor.isVertical == 0 ? popToNormalController() : popToShowController()
    }
    private func popToShowController(){
        
        present(RoomPopController(), animated: true, completion: nil)
    }
    private func popToNormalController(){
        navigationController?.pushViewController(RoomNormalController(), animated: true)
    }
}

