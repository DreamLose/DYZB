//
//  RecommendGameView.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
private let gameCellId : String = "gameCellId"
class RecommendGameView: UIView {
    var groups : [BaseGameModel]? {
        didSet {
            gameCollection.reloadData()
        }
    }
    @IBOutlet weak var gameCollection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        //设置子控件不随父控拉伸
        gameCollection.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
        gameCollection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        gameCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gameCellId)
    }
}
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        let recommendGameView = Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
        return recommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath) as! CollectionGameCell
        let group = groups?[indexPath.item]
        cell.gameModel = group
        
        return cell
    }
    
    
}
