//
//  WBNetWorkManager.swift
//  weiBo
//
//  Created by 刘 on 2017/8/28.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit
import AFNetworking


enum WBHTTPMethod {
    case GET
    case POST
}

class WBNetWorkManager: AFHTTPSessionManager {
    
//    这就是单例
    static let shared = WBNetWorkManager()
    
    
//    访问的令牌，都是基于token
    var accessToken : String? = ""
    
    func tokenRequest(method:WBHTTPMethod, URLString: String,parameters: [String :AnyObject]?,compltion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->())  {
//       0> 处理token
        guard accessToken != nil else {
            print("没有token，需要登录")
            
            compltion(nil, false)
            return
        }
        
//        1> 判断参数字典是否存在，
        var parameters = parameters
        
        if parameters == nil {
            parameters = [String : AnyObject]()
        }
        
//        2>设置字典
        parameters?["access_token"] = accessToken as AnyObject
        
//        发起正真的请求
        
        request(method: method, URLString: URLString, parameters: parameters, compltion: compltion)
        
    }
    
    func request(method:WBHTTPMethod, URLString: String,parameters: [String :AnyObject]?,compltion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()){
        
        
      
        let wbSuccess = { (task:URLSessionDataTask,json:AnyObject?)->() in
        
            compltion(json, true)
        }
        let wbFailure = { (task:URLSessionDataTask?,error:Error)->() in
            
            compltion(nil, false)
        }
        

        if method == .POST {
             post(URLString, parameters: parameters, progress: nil, success: wbSuccess as? (URLSessionDataTask, Any?) -> Void, failure: wbFailure)
        }else{
        
             get(URLString, parameters: parameters, progress: nil, success: wbSuccess as? (URLSessionDataTask, Any?) -> Void, failure: wbFailure)
            
        }
      
    }
    
}
