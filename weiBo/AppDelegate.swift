//
//  AppDelegate.swift
//  weiBo
//
//  Created by 刘 on 16/12/31.
//  Copyright © 2016年 刘. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
       
//       一些设置
        setupAdditions()
        //创建window
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible();
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{

    fileprivate func setupAdditions(){
    
        //      #available 是检测设备的版本
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                print("授权" + (success ? "成功":"失败"))
            }
        } else {
            
            let notifySettings = UIUserNotificationSettings(types: [.alert,.badge, .sound,], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
            // Fallback on earlier versions
        }
        

//     设置svp 的最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
//       2.设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
    }

}

