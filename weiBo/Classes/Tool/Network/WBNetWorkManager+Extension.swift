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
//        let params = ["access_token":"2.00ml8IrFsDUjxC114979b3900Ur2RT"]
        
        tokenRequest(method: .GET, URLString: urlString, parameters: nil) { (json, isSuccess) in
            
            print(json as! [String :Any])
            let result = json?["statuses"] as? [[String : AnyObject]]
            
            completion(result, isSuccess)
        }
        
    }
    
}







