//
//  WBVisitorView.swift
//  weiBo
//
//  Created by 刘 on 17/1/4.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    //MARK:私有空间
    
    fileprivate lazy var maskIconView = UIImageView(image:(UIImage.init(named: "visitordiscover_feed_mask_smallicon")))
    /// 图像视图
    fileprivate lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))
    
    /// 房子
    fileprivate lazy var houseView = UIImageView(image:#imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
    /// 提示文字 如果不行了 再加上冒号类型
    fileprivate lazy var tipLabel : UILabel = UILabel.yw_label(withText: "关注人有惊喜,回来看看有惊喜啊啊啊啊啊啊", fontSize: 14, color: UIColor.darkGray)
    
    /// 注册按钮
    fileprivate lazy var registerBtn : UIButton = UIButton.yw_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    fileprivate lazy var loginBtn : UIButton = UIButton.yw_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
 
    
    
    var visitorInfo = [String : AnyObject](){
        
        didSet{
            
            guard let imageName = visitorInfo["imageName"],let message = visitorInfo["message"] else { return  }
            
             //        /设置消息
            tipLabel.text = message as? String
            
//           如果首页已经有了，就不需要设置了
            if imageName as! String == "" {
//                开始旋转图标
                startAnimation()
                return;
            }
//            
            iconView.image = UIImage(named: imageName as! String)
//            其他视图不需要小房子和遮罩视图
            houseView.isHidden = true
            maskIconView.isHidden = true
            
        }
       
        
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        setupUI()
        
    
    
 
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    /// 转圈的动画
    ///
    /// - Returns: 0
    func startAnimation(){
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 5
//        完成之后是否删除动画
        animation.isRemovedOnCompletion = false
        iconView.layer.add(animation, forKey: nil)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}





// MARK: - 设置界面
extension WBVisitorView{
    
    fileprivate func setupUI(){
    
        backgroundColor = UIColor.yw_color(withHex: 0xEDEDED)
        tipLabel.textAlignment = .center
        let margin = 20.0
        
        //1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        //2.取消Autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //3.自动布局
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -50))
        
        
        addConstraint(NSLayoutConstraint(item: houseView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: CGFloat(0)))
         addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top , relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: CGFloat(margin)))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute:.width , relatedBy: .equal, toItem: nil, attribute:.notAnAttribute , multiplier: 1.0, constant: CGFloat(236)))
        
//        注册按钮
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .top , relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: CGFloat(margin)))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute:.left , relatedBy: .equal, toItem: tipLabel, attribute:.left , multiplier: 1.0, constant: CGFloat(0)))
          addConstraint(NSLayoutConstraint(item: registerBtn, attribute:.width , relatedBy: .equal, toItem: nil, attribute:.notAnAttribute , multiplier: 1.0, constant: CGFloat(100)))
        
//        addConstraint(NSLayoutConstraint(item: registerBtn, attribute:.height , relatedBy: .equal, toItem: nil, attribute:.notAnAttribute , multiplier: 1.0, constant: CGFloat(44)))
        
        //        登录按钮
        addConstraint(NSLayoutConstraint(item:loginBtn, attribute: .top , relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: CGFloat(margin)))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute:.right , relatedBy: .equal, toItem: tipLabel, attribute:.right , multiplier: 1.0, constant: CGFloat(0)))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute:.width , relatedBy: .equal, toItem: nil, attribute:.notAnAttribute , multiplier: 1.0, constant: CGFloat(100)))
        
//         addConstraint(NSLayoutConstraint(item: loginBtn, attribute:.height , relatedBy: .equal, toItem: registerBtn, attribute:.height , multiplier: 1.0, constant: 0.0))
//    遮罩图片
        let viewDict = ["maskIconView":maskIconView,"loginBtn":loginBtn] as [String : Any]
//        let metrics = ["spacing":50]
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: viewDict))

        addConstraint(NSLayoutConstraint(item: maskIconView, attribute:.bottom , relatedBy: .equal, toItem: tipLabel, attribute:.top , multiplier: 1.0, constant: 70))
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[loginBtn]|", options: [], metrics: metrics, views: viewDict))
        
        
    }
    
}
























