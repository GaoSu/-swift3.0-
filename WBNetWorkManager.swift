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
    
    func request(method:WBHTTPMethod, URLString: String,parameters: [String :AnyObject],compltion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()){
      
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
