//
//  WBSDiscoverViewController.swift
//  weiBo
//
//  Created by 刘 on 16/12/31.
//  Copyright © 2016年 刘. All rights reserved.
//

import UIKit

class WBSDiscoverViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        模拟token过期
        WBNetWorkManager.shared.userAccount.access_token = nil
        print("模拟token过期")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
