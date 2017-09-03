//
//  WBBaseViewController.swift
//  weiBo
//
//  Created by 刘 on 16/12/31.
//  Copyright © 2016年 刘. All rights reserved.
//

import UIKit


/// 1.extension 中不能有属性

/// 2. extension 不能重写父类的方法。重写是子类的职责，扩展只是对类的扩展
class WBBaseViewController: UIViewController {

    var userLogOn = true
    
    
    lazy var navItem = UINavigationItem()
    
    /// 自定义导航栏
    lazy var nagvgationBar : UINavigationBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.yw_screenWidth(), height: 64))
    
    var vistorViewDictory = [String : String]()
    
    /// 表格视图
    var tableView : UITableView? //<! sss
    
    /// 刷新控件
    var refreshContror : UIRefreshControl?
    
    /// 是否上拉
    var isPullUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    /// 重写title 的didSet
    override var title: String?{
        didSet{
        navItem.title = title
        }
    }
    
    /// 加载数据，让子类重写吧
    func loadData() -> () {
//        如果子类不实现任何方法，默认关闭刷新
        refreshContror?.endRefreshing()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - 设置界面
extension WBBaseViewController{

     func setupUI() {
        
    view.backgroundColor = UIColor.white
        
    automaticallyAdjustsScrollViewInsets = false
        
    setupNavigationBar()
    setupTableView()
    userLogOn ? setupTableView() : setupVistorView()
  
        
        
    }
    
    /// 设置访客视图
    func setupVistorView(){
    
        let vistorView = WBVisitorView(frame: view.bounds)
       
        view.insertSubview(vistorView, belowSubview: nagvgationBar)
        
        vistorView.visitorInfo = vistorViewDictory as [String : AnyObject]
        
    }
    
    /// 为子类方便
    /** 子类 */
    func setupTableView(){
    
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: nagvgationBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
//        tableView?.backgroundColor = UIColor.cyan
        //内容设置缩进 去除nav和tabbar的高度
        tableView?.contentInset = UIEdgeInsetsMake(nagvgationBar.bounds.height, 0,tabBarController?.tabBar.yw_height ?? 49, 0)
        //导航条的缩进
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
//        
        refreshContror = UIRefreshControl.init()
        
        tableView?.addSubview(refreshContror!)
        
        refreshContror?.addTarget(self, action:#selector(loadData), for: .valueChanged)
        
    
    }
    
    /// 设置导航栏
    
    /// 设置导航栏
    private func setupNavigationBar(){
        //这里可能有的时候不提示
    view.addSubview(nagvgationBar)
        
    nagvgationBar.items = [navItem]
        
    nagvgationBar.barTintColor = UIColor.yw_color(withHex: 0xF6F6F6)
        
        //标题的颜色
    nagvgationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        //
        
    nagvgationBar.tintColor = UIColor.orange
    
    }
}

//MARK: - tableView相关
///Type 'WBBaseViewController' does not conform to protocol 'UITableViewDataSource'
extension WBBaseViewController:UITableViewDelegate,UITableViewDataSource{
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
///
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        let count = tableView.numberOfRows(inSection: section)
        if (row == count - 1) && !isPullUp {
            print("上拉刷新")
            isPullUp = true
//            开始刷新
            loadData()
            
        }
        
    }
}
