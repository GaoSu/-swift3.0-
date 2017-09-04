//
//  WBMainViewController.swift
//  weiBo
//
//  Created by 刘 on 16/12/31.
//  Copyright © 2016年 刘. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

 //WARNING: 为什么永不了私有的变量
  /// 发布按钮
   fileprivate lazy var pushlish:UIButton = UIButton.yw_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    fileprivate var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupChildController()
        
        setupPublishBtn()
        
        setupTimer()
        
        delegate = self
        
//        登录的通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(n:)), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        timer?.invalidate()
    }
    
    /// 设置设备方向//子控制也会禁止横屏。
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return.portrait
    }
    
    
//   用户登录的方法
    @objc fileprivate func userLogin(n:Notification){
    
        print("用户登录")
    
    
    }
    
    /// 发布的方法
    @objc func pushlishAction() -> () {
     print("发布")
    
        let vc = UIViewController()
        
        vc.view.backgroundColor = UIColor.yw_random()
        
        let  nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true) { 
            
        }
    }
}


//MARK:UITabBarControllerDelegate

extension WBMainViewController : UITabBarControllerDelegate{
//已经选中
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
//        1>获取控制器在数组中的索引
        let index = (childViewControllers as NSArray).index(of: viewController)
        
//        2>判断当前是首页，点击的也是首页
        if selectedIndex == 0 && index == selectedIndex {
            
            print("点击首页")
//           3> 让表格滚动到顶部
//           a) 先获取vc
            let nav = childViewControllers.first as! UINavigationController
            let vc = nav.childViewControllers.first as! WBHomeViewController
//            b）滚动到顶部
            vc.tableView?.setContentOffset(CGPoint.init(x: 0, y: -64), animated: true)
//            4>s刷新数据 - 增加延迟，是保证表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                vc.loadData()
            })
//             5> 清楚badge 
            self.tabBar.items?.first?.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
        
    }
// 将要选中
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
      return true
    }

    
}

//MARK:设置计时器
extension WBMainViewController{
 

    fileprivate func setupTimer(){
     
        timer = Timer.scheduledTimer(timeInterval: 5, target:self, selector:#selector(getunreadCount), userInfo: nil, repeats: true)
     
        
    }
    
    @objc func getunreadCount(){
    
        if !WBNetWorkManager.shared.userLogOn {
//            没有登录就不用往下面进行了
            return
        }
        
        // 获取微博的未读数
        WBNetWorkManager.shared.unreadCount { (count) in
            print("有\(count)条微博未读")
//            设置首页的角标
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
//            
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

//MARK:end

//类似于 oc 的分类，不能定义属性//这个地方要对extension 进行理解 不能重写父类本类方法，子类能重写，extension只负责扩展
//里面的方法不能用private 现在的private是真正的私有，而fileprivate 是文件内私有
  extension WBMainViewController{

    /// 设置所有的子控制器
   fileprivate  func setupChildController(){
    

    guard let pathString = (Bundle.main .path(forResource: "demo", ofType: "plist")),let array = NSArray(contentsOfFile: pathString) as? [[String :Any]]  else {
        return
    }
    
//    let pathString = (Bundle.main .path(forResource: "demo", ofType: nil))
//    let array = NSArray(contentsOfFile: pathString)
    
    
//    let array:[[String :Any]] = [
//            ["clsName":"WBHomeViewController", "title":"首页","imageName":"home","visitorViewInfo":["imageName":"","message":"关注一些人，回这里看看有什么惊喜"]],
//            ["clsName":"WBMessageViewController", "title":"消息","imageName":"message_center","visitorViewInfo":["imageName":"visitordiscover_image_message","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
//             
//            ["clsNamge":"VC"],["clsName":"WBSDiscoverViewController", "title":"发现","imageName":"discover","visitorViewInfo":["imageName":"visitordiscover_image_message","message":"登陆后，最新、最热的微博尽在掌握中，不会再于实事潮流擦肩而过"]],
//            ["clsName":"WBProfileViewController", "title":"我","imageName":"profile","visitorViewInfo":["imageName":"visitordiscover_image_profile","message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
//    ]
//    
//    (array as NSArray).write(toFile: "/Users/liu/Desktop/demo.plist", atomically: true)
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict ))
        }
       
        viewControllers = arrayM
   }

    //MARK: 从字典中获得控制器
  fileprivate  func controller(dict:[String: Any]) -> UIViewController{
        
    guard let clsName = dict["clsName"] as? String,
        let title = dict["title"] as? String,
        let  imageName = dict["imageName"] as? String,
        let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseViewController.Type,
      let visitorViewInfo = dict["visitorViewInfo"] as? [String : String]
    
        else{
            
        return UIViewController()
            
        }
  
        //创建视图控制器
        let vc = cls.init()
        vc.title = title
        vc.vistorViewDictory = visitorViewInfo
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
//    设置访客视图的字典
    
        //改变字体颜色和大小
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .highlighted)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12)], for: .normal)
        let nav = WBNavigationViewController(rootViewController: vc)
        return nav
    }
    //MARK: 设置发布按钮
   fileprivate func setupPublishBtn() {
       tabBar.addSubview(pushlish)
        
        //计算按钮的宽
        let count = CGFloat(childViewControllers.count)
        let width = tabBar.bounds.width / count - 1
        
        pushlish.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)

        pushlish.addTarget(self, action: #selector(pushlishAction), for: .touchUpInside)
        
    }

}



