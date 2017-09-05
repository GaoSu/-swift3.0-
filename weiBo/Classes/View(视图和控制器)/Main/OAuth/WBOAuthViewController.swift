//
//  WBOAuthViewController.swift
//  weiBo
//
//  Created by 刘 on 2017/9/4.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit

/// 通过webView 加载授权页
class WBOAuthViewController: UIViewController {

    fileprivate lazy var webView = UIWebView()
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        title = "登录新浪微博"
//        设置导航栏  在这里可以在后面加上isBack 之后就会有返回的箭头
        
        

//       
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBack: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @objc func close(){
    
        dismiss(animated: true, completion: nil)
    
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
