//
//  WBTitleButton.swift
//  weiBo
//
//  Created by 刘 on 2017/9/9.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    /// 重载构造函数:和遍历构造函数有什么区别 FIXMI:
    ///title为nil 就显示"首页"
  
    init(title:String?){
    
        super.init(frame: CGRect())
//       1. 判断title是否为nil
        if title == nil {
            setTitle("首页", for: [])
        }else{
            //            设置向下的箭头
            setImage(UIImage.init(named: "navigationbar_arrow_down"), for: [])
            setImage(UIImage.init(named: "navigationbar_arrow_up"), for: .selected)
            setTitle(title! + " ", for: [])

        }
//        2.设置字体和大小
        setTitleColor(UIColor.darkGray, for: [])
        setTitleColor(UIColor.black, for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
//     3.这一步很重要设置大小
        sizeToFit()
//      4. 这个更重要啊
        layoutSubviews()
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 重新布局
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        guard  let titleLabel = titleLabel, let imageView = imageView else {
            return
        }
       print("\(titleLabel) -----\(imageView)")
      
       titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.size.width, dy: 0)
       imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.size.width, dy: 0)
        
        print("\(titleLabel)----- \(imageView)")
       
    }
    
  
}
