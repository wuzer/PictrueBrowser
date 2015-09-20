//
//  AppDelegate.swift
//  choosePicture
//
//  Created by Jefferson on 15/9/11.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = PictureSelectorViewController()
        
        window?.makeKeyAndVisible()
        return true
    }

    
}

