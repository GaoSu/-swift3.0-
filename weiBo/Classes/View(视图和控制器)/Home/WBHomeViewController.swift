//
//  WBHomeViewController.swift
//  weiBo
//
//  Created by 刘 on 16/12/31.
//  Copyright © 2016年 刘. All rights reserved.
//

import UIKit

 fileprivate let cellId = "cellId"


class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// 显示好友
    func showFirends(){
    
    }

}

// MARK: - tableView相关
extension WBHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
    }
}

// MARK: - 设置界面
extension WBHomeViewController{
    
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFirends))
    
    }
    
    override func setupTableView() {
        super.setupTableView()

        tableView?.register(UITableViewCell.self, forCellReuseIdentifier:cellId)
        //取消分割线
        tableView?.separatorStyle = .none
    }
}
