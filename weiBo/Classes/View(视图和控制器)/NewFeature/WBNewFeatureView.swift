//
//  WBNewFeatureView.swift
//  weiBo
//
//  Created by 刘 on 2017/9/10.
//  Copyright © 2017年 刘. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBAction func enterClick(_ sender: UIButton) {
        removeFromSuperview()
    }
    /// 用一个类方法来加载xib
    ///
    /// - Returns: 返回自己
    class func newFeatureV() ->(WBNewFeatureView){
        
        let nib = UINib.init(nibName: "WBNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: self, options: nil)[0] as? WBNewFeatureView
        
        //        let v = Bundle.main.loadNibNamed("WBWelcomeView", owner: self, options: nil)?[0] as? WBWelcomeView
        v?.frame = UIScreen.main.bounds
        return v!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let count = 4
        let rect = UIScreen.main.bounds
        

        for i in 0..<count {
            let imageName = "new_feature_\(i + 1)"
            let imageV = UIImageView.init(image: UIImage.init(named: imageName))
            imageV.frame = rect.offsetBy(dx: CGFloat(i) * WBScreenWidth, dy: 0)
            scrollView.addSubview(imageV)
          
        }
//       一定要设置scrollview的contentSize
        scrollView.contentSize = CGSize.init(width: (WBScreenWidth * CGFloat(count + 1)), height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self as UIScrollViewDelegate
    }
 
}


// MARK: - UIScrollViewDelegate
extension WBNewFeatureView : UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / WBScreenWidth)
        if page == scrollView.subviews.count {
             removeFromSuperview()
        }
//       
        enterButton.isHidden = (page != scrollView.subviews.count - 1)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / WBScreenWidth + 0.5)
//        一旦滚动就隐藏
        enterButton.isHidden = true
        
        pageControl.currentPage = page
        
        if page == scrollView.subviews.count {
           
          pageControl.isHidden = true
        }
        
    }

}
