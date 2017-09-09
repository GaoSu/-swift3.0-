//
//  UIBarButtonItem+Extension.swift
//  weiBo
//
//  Created by 刘 on 17/1/4.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    /// 创建UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: 字体的大小
    ///   - target: target
    ///   - action: action
    
    /*
     convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
     便利构造函数的特点：
     1、便利构造函数通常都是写在extension里面
     2、便利函数init前面需要加载convenience
     3、在便利构造函数中需要明确的调用self.init()
     
     */
//    convenience init(<#parameters#>) {
//        <#statements#>
//    }
     convenience init(title:String, fontSize:CGFloat = 16,target: Any?,action:Selector,isBack:Bool = false) {
         self.init()
        let btn : UIButton = UIButton.yw_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        let imageName = "navigationbar_back_withtext"
        
        if isBack {
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        btn.addTarget(target, action: action, for: .touchUpInside) 
        
        self.customView = btn

    }
}
