//
//  WBNetWorkManager+Extension.swift
//  weiBo
//
//  Created by 刘 on 2017/8/29.
//  Copyright © 2017年 刘. All rights reserved.
//

import Foundation

extension WBNetWorkManager{

    
    func statusList(completion:@escaping (_ list :[[String :AnyObject]]?,_ isSuccess:Bool)->()) {
        
     
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00ml8IrFsDUjxC114979b3900Ur2RT"]
        
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            print(json ??  "");
            
            let result = json?["status"] as? [[String : AnyObject]]
            
            completion(result, isSuccess)
        }
        
        
    }
    
}







