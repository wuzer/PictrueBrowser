//
//  UIImage+Extension.swift
//  choosePicture
//
//  Created by Jefferson on 15/9/11.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaleImage(width: CGFloat) -> UIImage {
        
        // 判断是否小于制定宽度, 直接返回
        if self.size.width < width {
            return self
        }
        
        // 计算等比例缩放高度
        let scale = self.size.height / self.size.width
        
        let height = width * scale
        
        // 创建图像上下文
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        
        // 在指定区域填充绘图
        drawInRect(CGRect(origin: CGPointZero, size: size))
        
        // 获得绘制结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return result
    }
}
