//
//  WBStatusListViewModel.swift
//  weiBo
//
//  Created by 刘 on 2017/8/30.
//  Copyright © 2017年 刘. All rights reserved.
//

import Foundation
///
/*
 
 父类的选择
 字典转模型时需要继承
 如果只是封装一些逻辑，可以不要父类
 
// 负责微博的数据处理
 上拉，下拉，刷新
 */
class WBStatusListViewModel {
    
    lazy var statusList = [WBStatus]()
    
    func loadStatus(compltion: @escaping (_ isSuccess: Bool) -> ()){
     
        
        WBNetWorkManager.shared.statusList { (list, isSuccess) in
//            字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus]  else{
            
                return
            }
//           2.拼接数据
            print("刷新了\(array.count) 条")
            self.statusList += array
//          3.回调
            compltion(isSuccess)
            
        }
        
    }
    
}
