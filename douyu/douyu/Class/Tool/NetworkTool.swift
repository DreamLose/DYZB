//
//  NetworkTool.swift
//  douyu
//
//  Created by 2020 on 2020/7/14.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit
import Alamofire
enum mathodType {
    case GET
    case POST
}
class NetworkTool {
    class func requestData(type:mathodType,urlString:String,param:[String : String]? = nil, finshedCallBack : @escaping(_ response : AnyObject) -> ()) {
        
        let mathod = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: mathod, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            finshedCallBack(result as AnyObject)
        }
        
    }
}
