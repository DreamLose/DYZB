//
//  RecommendViewModel.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [anchorGroupModel] = [anchorGroupModel]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : anchorGroupModel = anchorGroupModel()
    private lazy var prettyDataGroup : anchorGroupModel = anchorGroupModel()
    
}
extension RecommendViewModel {
    func requestDate(finshedCallBack : @escaping() -> ()) {
        
        let param = ["limit":"4","offset":"0","time": NSDate.getCurrentTime()]
        let workGroup = DispatchGroup()
       
        //请求推荐数据
        workGroup.enter()
        NetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",param: ["time": NSDate.getCurrentTime()]) { (result) in
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
           
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dic in dataArr {
                let anchor = AnchorModel(dict: dic)
                self.bigDataGroup.achors.append(anchor)
            }
            
            workGroup.leave()
        }
        //请求颜值数据
//        http://capi.douyucdn.cn/api/v1/getVerticalRoom
        workGroup.enter()
        NetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", param: param) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            for dic in dataArr {
                let anchor = AnchorModel(dict: dic)
                self.prettyDataGroup.achors.append(anchor)
            }
            
            workGroup.leave()
        }
        
        //请求2 --12 的数据
        workGroup.enter()
        NetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", param: param) { (result) in
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            for dic in dataArr {
                let group = anchorGroupModel(dict: dic)
                self.anchorGroups.append(group)
            }
            
            workGroup.leave()
            
        }
        workGroup.notify(queue: DispatchQueue.main) {
            
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finshedCallBack()
        }
    }
    
    func requestCycle(finshedCallback : @escaping() -> ()) {
        NetworkTool.requestData(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", param: ["version" : "2.300"]) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            for dict in dataArr {
                let cycModel = CycleModel(dict: dict)
                self.cycleModels.append(cycModel)
            }
            
            finshedCallback()
        }
    }
}
