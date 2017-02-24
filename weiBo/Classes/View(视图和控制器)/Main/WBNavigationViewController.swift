//
//  WBNavigationViewController.swift
//  weiBo
//
//  Created by 刘 on 16/12/31.
//  Copyright © 2016年 刘. All rights reserved.
//

import UIKit

class WBNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //隐藏navgationBar
        navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    /// 所有push 都会走这个方法
    ///
    /// - Parameters:
    ///   - viewController: push的控制器
    ///   - animated: animate
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
     // 如果不是跟控制器就hide
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = (viewController as? WBBaseViewController) {
                var title = "返回"
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, fontSize: 16, target: self, action: #selector(popToParent), isBack: true)
            }
            
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func popToParent (){
    
        popViewController(animated: true)
    }
}
