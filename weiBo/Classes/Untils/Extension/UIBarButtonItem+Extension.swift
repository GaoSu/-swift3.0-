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
    convenience init(title:String, fontSize:CGFloat = 16,target: Any?,action:Selector,isBack:Bool = false) {
    

        let btn : UIButton = UIButton.yw_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        let imageName = "navigationbar_back_withtext"
        
        if isBack {
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        btn.addTarget(target, action: action, for: .touchUpInside) 
        
        self.init(customView:btn)
    }
    
}
