//
//  WBNetWorkManager+Extension.swift
//  weiBo
//
//  Created by 刘 on 2017/8/29.
//  Copyright © 2017年 刘. All rights reserved.
//

import Foundation



extension WBNetWorkManager{

    
    /// 微博列表
    ///
    /// - Parameters:
    ///   - since_id: 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    ///   - max_id: 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    ///   - completion: 回调参数
    
    func statusList(since_id : Int64,max_id : Int64, completion:@escaping (_ list :[[String :AnyObject]]?,_ isSuccess:Bool)->()) {
        
     
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00ml8IrFsDUjxC114979b3900Ur2RT"]
        
        let params = ["since_id":since_id ,"max_id":max_id > 0 ? max_id - 1 : 0]
        
        tokenRequest(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            print(json as? [String :Any] ?? "为空")
            let result = json?["statuses"] as? [[String : AnyObject]]
            
            completion(result, isSuccess)
        }
        
    }
    
    
    /// 返回微博的未读数量
    func unreadCount(compltion:@escaping (_ count : Int)->()) {
       
        
//        if uid == nil {
//            return
//        }
        guard uid != nil else {
            return
        }
       
        let URLString = ""
        let params = ["uid" : uid]
        
        
        tokenRequest(method: .GET, URLString: URLString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            
            let dict = json as? [String : AnyObject]
            let count = dict?["status"] as? Int
            compltion(count ?? 0)
//            print(json)
            
        }
        
    }
    
}







