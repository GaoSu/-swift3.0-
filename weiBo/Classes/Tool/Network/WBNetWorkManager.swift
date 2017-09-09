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
    static let shared :WBNetWorkManager = {
    
        let instance = WBNetWorkManager()
//    设置反序列化支持的类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
        return instance
    }()

    
//    访问的令牌，都是基于token
//    token 的过期处理,也可以在这里处理多账号登录 //长时间没有登录需要从新登录
//    var accessToken : String? // = "2.00G4abYG0iodTc16cfad29f65tuMUD"
//    var uid :String? = "6008150368"
    
     lazy var userAccount = WBUserAccount()
    
    var userLogOn : Bool {
         return  (userAccount.access_token != nil) ? true : false
    }
    
    
    func tokenRequest(method:WBHTTPMethod, URLString: String,parameters: [String :AnyObject]?,compltion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->())  {
//       0> 处理token
        guard userAccount.access_token != nil else {
            print("没有token，需要登录")
//                ：发送通知。需要登录
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
            
            compltion(nil, false)
            return
        }
        
    
//        1> 判断参数字典是否存在，
        var parameters = parameters
        
        if parameters == nil {
            parameters = [String : AnyObject]()
        }
        
//        2>设置字典
        parameters?["access_token"] = userAccount.access_token as AnyObject
        
        //        发起正真的请求
        
        request(method: method, URLString: URLString, parameters: parameters, compltion: compltion)
        
    }
    
    
    func request(method:WBHTTPMethod, URLString: String,parameters: [String :AnyObject]?,compltion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()){
        
        let wbSuccess = { (task:URLSessionDataTask,json:Any?)->() in
        
            compltion(json as AnyObject, true)
        }
//        失败回调
        let wbFailure = { (task:URLSessionDataTask?,error:Error)->() in
            
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token 过期了")
                
//                FIXME：发送通知。token过期
                NotificationCenter.default.post(name:Notification.Name(rawValue: WBUserShouldLoginNotification) , object:"bad token")
            }
            print("请求失败")
            compltion(nil, false)
        }
        
        if method == .POST {
            
             post(URLString, parameters: parameters, progress: nil, success: wbSuccess  , failure: wbFailure)
        }else{
            
//            get(URLString, parameters: parameters, progress: nil, success: { (task, json) in
//                print(json ?? "")
//            }, failure: { (task,error) in
//               print(error)
//            })
           
            get(URLString, parameters: parameters, progress: nil, success: wbSuccess, failure: wbFailure)
        }
        
    }
    
}
