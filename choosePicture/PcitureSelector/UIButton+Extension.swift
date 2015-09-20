//
//  UIButton+Extension.swift
//  choosePicture
//
//  Created by Jefferson on 15/9/11.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, imageNamed: String, color: UIColor, fontSize: CGFloat) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageNamed), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    /// 便利构造函数
    convenience init(imageName: String) {
        self.init()
        
        setImageName(imageName)
    }
    
    /// 设置图像&高亮图像
    func setImageName(imageName: String) {
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_Highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }
    
    
}
