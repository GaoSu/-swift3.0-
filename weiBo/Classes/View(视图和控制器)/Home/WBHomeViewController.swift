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

    
   fileprivate lazy var statusList = [String]()
   fileprivate lazy var wbStatusListViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//登录才加载数据
        WBNetWorkManager.shared.userLogOn ? loadData() : ()
     
        // Do any additional setup after loading the view.
    }
    
    
    /// 加载数据
    override func loadData() {
        

        wbStatusListViewModel.loadStatus(pullUp: self.isPullUp) { (isSuccess,shouldRefresh) in
           
            //       结束刷新
            self.refreshContror?.endRefreshing()
//            回复上拉加载更多的标记
            self.isPullUp = false
        
            if shouldRefresh {
            
                self.tableView?.reloadData()
                
            }
        }
        
//        WBNetWorkManager.shared.statusList { (list, isSuccess) in
//            print(list ?? "nil")
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            
//        };
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//          
////            加载数据
//            for i in 0..<10 {
//                
//                if self.isPullUp {
//                
//                    self.statusList.append("上拉\(i)")
//                }else{
//                
//                self.statusList.insert(i.description, at: 0)
//                    
//                }
//            }
////       结束刷新
//        self.refreshContror?.endRefreshing()
//        self.isPullUp = false
//            
//        self.tableView?.reloadData()
//            
//        }
    }
    /// 显示好友
    func showFirends(){
    
    }

}

// MARK: - tableView相关
extension WBHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wbStatusListViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath);
        cell.textLabel?.text = wbStatusListViewModel.statusList[indexPath.row].text
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - 设置界面
extension WBHomeViewController{
    
    override func setupUI() {
        super.setupUI()
        
//        //设置导航栏
//        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFirends))
    
    }
    
    override func setupTableView() {
        super.setupTableView()

        tableView?.register(UITableViewCell.self, forCellReuseIdentifier:cellId)
        //取消分割线
        tableView?.separatorStyle = .none
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(clickFriend), isBack:false)
        
        setupNavTitle()
    }
    
    /// 点击好友
    @objc fileprivate func clickFriend(){
    
        
    }
    
    /// 设置导航标题
    fileprivate func setupNavTitle(){
    
        let title = WBNetWorkManager.shared.userAccount.screen_name
        
        let button = WBTitleButton(title: title)
    
        navItem.titleView = button
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    
    /// 导航标题的点击方法
    ///
    /// - Parameter button: button
    @objc fileprivate func clickTitleButton(button:WBTitleButton){
    
        button.isSelected = !button.isSelected
    }
}

