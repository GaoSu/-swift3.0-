//
//  WBStatus.swift
//  weiBo
//
//  Created by 刘 on 2017/8/30.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit
import YYModel
class WBStatus: NSObject {

//    如果不写Int64 在低于5s上 会溢出
    var id : Int64 = 0
    
//  
    var text : String?
    
//    重写 decription的计算性属性
 
    override var description: String{
     
        return yy_modelDescription()
    }
    
    
    
}
