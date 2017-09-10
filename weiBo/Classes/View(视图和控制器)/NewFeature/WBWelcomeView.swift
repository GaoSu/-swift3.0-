//
//  WBWelcomeView.swift
//  weiBo
//
//  Created by 刘 on 2017/9/10.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit
import SDWebImage
class WBWelcomeView: UIView {

    

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    /// 用一个类方法来加载xib
    @IBOutlet weak var iconBottom: NSLayoutConstraint!
    ///
    /// - Returns: 返回自己
    class func welcomeV() ->(WBWelcomeView){
    
        let nib = UINib.init(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: self, options: nil)[0] as? WBWelcomeView
        
//        let v = Bundle.main.loadNibNamed("WBWelcomeView", owner: self, options: nil)?[0] as? WBWelcomeView
        v?.frame = UIScreen.main.bounds
        return v!
    }
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        设置属=属性值及动画
//        1.0 设置属性
        guard let url =  URL.init(string:WBNetWorkManager.shared.userAccount.avatar_large) else { return  }
        
      
        iconImageView.sd_setImage(with: url, placeholderImage: UIImage.init(named:"avatar_default_big"))
       
        nameLabel.text = WBNetWorkManager.shared.userAccount.screen_name
        
//        2.0设置动画
         iconBottom.constant = WBScreenHeight - 200

        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
              self.layoutIfNeeded()
            
        }) { (_) in
            
            UIView.animate(withDuration: 0.5, animations: { 
               self.nameLabel.alpha = 1
            }, completion: { (_) in
//                移除该view
               self.removeFromSuperview()
            })
        }
        
    }
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//    }
//
    
}
