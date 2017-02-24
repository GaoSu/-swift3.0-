//
//  Bundle+Extension.swift
//  weiBo
//
//  Created by 刘 on 17/1/3.
//  Copyright © 2017年 刘. All rights reserved.
//

import Foundation

extension Bundle{

    
    /// 计算性属性类似函数，没有参数，但是有返回值
    var nameSpace : String{
     return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
