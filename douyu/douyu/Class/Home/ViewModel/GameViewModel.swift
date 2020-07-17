//
//  GameViewModel.swift
//  douyu
//
//  Created by 2020 on 2020/7/15.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class GameViewModel {
   lazy var gameModels : [GameModel] = [GameModel]()
}
extension GameViewModel{
    func loadAllGameDate(finshedCallback : @escaping () -> ()){
        NetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", param: ["shortName ":" game"]) { (result) in
             guard let resultDict = result as? [String : Any] else {return}
           guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
           
           for dict in dataArr {
               self.gameModels.append(GameModel(dict: dict))
           }
           
           finshedCallback()
        }
        
    }
}
