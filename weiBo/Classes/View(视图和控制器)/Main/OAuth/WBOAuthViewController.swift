//
//  WBOAuthViewController.swift
//  weiBo
//
//  Created by 刘 on 2017/9/4.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit
import SVProgressHUD
/// 通过webView 加载授权页
class WBOAuthViewController: UIViewController {

    fileprivate lazy var webView = UIWebView()
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        webView.scrollView.isScrollEnabled = false
        
        title = "登录新浪微博"
        
        webView.delegate = self
//        设置导航栏  在这里可以在后面加上isBack 之后就会有返回的箭头

//       
        
//        UIBarButtonItem(
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", fontSize: 16, target: self, action: #selector(autoFill), isBack: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//加载授权页面

        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectUrl)"
        
        guard let url = URL.init(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)//这里的强制解包没事
        
        webView.loadRequest(request)
        
        
        // Do any additional setup after loading the view.
    }

    
    @objc func close(){
    
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    
    }
    
//    MARK:自动填充
    
    /// 自动填充-webView 的注入，直接通过 js 修改 ‘修改本地浏览器中’ 缓存的内容
    
    @objc func autoFill(){
    
        let js = "document.getElementById('userId').value = '13794408277'; " +
        "document.getElementById('passwd').value = 'qwer123';"

//        让webview直行js
        webView.stringByEvaluatingJavaScript(from: js)
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



// MARK: - UIWebViewDelegate
extension WBOAuthViewController : UIWebViewDelegate{
    

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.url?.absoluteString.hasPrefix(WBRedirectUrl) == false {
            return true
        }
        
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            close()
            return false
        }
        
        let code = request.url?.query?.substring(from: "code=".endIndex)
        
        print("授权码 - \(String(describing: code))")
//        换取aceess_token
        WBNetWorkManager.shared.loadAccessToken(code: code!) { (isSuccess) in
            

            if isSuccess{
//                SVProgressHUD.show(withStatus: "登陆成功")
//                SVProgressHUD.showInfo(withStatus: "登录成功")
//                发送通知
//                只管发送，不管有没有监听者
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserLoginSuccessNotification), object: nil)

                self.close()
            }else{
//            失败的时候提示用户
                 SVProgressHUD.showInfo(withStatus: "网络请求失败")
//              SVProgressHUD.setStatus("网络请求失败")
                
            }
            
        }
        
        
      return false
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
}



