//
//  WBUserAccount.swift
//  weiBo
//
//  Created by 刘 on 2017/9/6.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit


fileprivate let accountfile : NSString = "useraccount.json"

class WBUserAccount: NSObject {


    /// 访问令牌
    var access_token : String?
    
    /// 用户代号
    var uid : String?
    
    var expires_in : TimeInterval = 0{
     
        didSet{
        
            espiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    /// 过期日期
    var espiresDate : Date?
    

    override var description: String{
      return yy_modelDescription()
    }
    
    /// 昵称
    var screen_name : String?
    
    var avatar_large = String()
    
    
    
    
    
    override init() {
        super.init()
//        从磁盘中加载保存的文件-> 字典
//        1> 加载磁盘文件到二进制数据，如果失败直接返回
        
        
        guard let path = accountfile.yw_appendDocumentDir(),let data = NSData(contentsOfFile: path),let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String :AnyObject]  else { return  }
        
        
//        2.使用字典设置属性值
//用户登录的关键操作
        yy_modelSet(with: dict ?? [:])
        
        print(self)
//        3.判断token是否过期
        if espiresDate?.compare(Date()) != .orderedDescending {
            print("账号过期")
            
            access_token = nil
            uid = nil
//            删除账号文件
           _ = try? FileManager.default.removeItem(atPath: path)
        }
        
    }
    
    /// 1.偏好设置
    
    /// 2.沙盒-归档 - plist/json
    
    /// 3 数据库（FMDB、coreData

    /// 钥匙串访问 (SSKeychain)
    func saveUserAccount() {
        
//        1.模型转字典
        var dict = (self.yy_modelToJSONObject() as?[String :AnyObject]) ?? [:]
        
//        这里需要删除 expires_in
        dict.removeValue(forKey: "expires_in")
//        2.字典序列化 data
       
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []), let filePath = accountfile.yw_appendDocumentDir() else{
            return
        }
        
        (data as NSData).write(toFile: filePath, atomically: true)
        
    }
    
    
}
