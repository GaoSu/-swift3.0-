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

fileprivate let maxPullupTimes = 3

class WBStatusListViewModel {
    
    lazy var statusList = [WBStatus]()
    
    private var errorTimes = 0
    
/** 加载数据 */
    /// 加载数据
    ///
    /// - Parameters:
    ///   - pullUp: 是否上拉
    ///   - compltion:isSuccess 是否成功 ，shouldRefresh是否应该加载更多数据
    func loadStatus(pullUp:Bool , compltion: @escaping (_ isSuccess: Bool,_ shouldRefresh:Bool) -> ()){
     
//      since_id  取出微博的第一天微博的id
        let since_id = pullUp ? 0 : statusList.first?.id ?? 0
//        max_id
        let max_id = pullUp ? statusList.last?.id ?? 0 : 0
        
        if  errorTimes > maxPullupTimes {
            

            compltion(true, false)
            return
        }
        

        WBNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
//            字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus]  else{
            compltion(isSuccess, false)
                return
            }
//           2.拼接数据
            print("刷新了\(array.count) 条")
            
            if pullUp {
                self.statusList += array
            }else{
            
                //下拉刷新，结果应该拼接在数组的前面
                self.statusList = array + self.statusList
            }
            
            
            if pullUp && array.count == 0{
             
                self.errorTimes += 1
                 compltion(isSuccess, false)
                
            }else{
             
                 compltion(isSuccess, true)
            }
            
        }
        
    }
    
}
