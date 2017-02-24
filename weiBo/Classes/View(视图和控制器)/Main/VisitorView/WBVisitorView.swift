//
//  WBVisitorView.swift
//  weiBo
//
//  Created by 刘 on 17/1/4.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        setupUI()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK:私有空间
    
    /// 图像视图
   fileprivate lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))
    
    /// 房子
   fileprivate lazy var houseView = UIImageView(image:#imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
    /// 提示文字 如果不行了 再加上冒号类型
    fileprivate lazy var tipLabel : UILabel = UILabel.yw_label(withText: "关注人有惊喜", fontSize: 14, color: UIColor.darkGray)
    
    /// 注册按钮
    fileprivate lazy var registerBtn : UIButton = UIButton.yw_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    fileprivate lazy var loginBtn : UIButton = UIButton.yw_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
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
    
        backgroundColor = UIColor.white
        
        //1.添加控件
        addSubview(iconView)
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

        
    }
    
}
