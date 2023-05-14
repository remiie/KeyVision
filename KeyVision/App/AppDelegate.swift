//
//  AppDelegate.swift
//  KeyVision
//
//  Created by Роман Васильев on 14.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UITabBar.appearance().selectionIndicatorImage = UIImage.getImageWithColorPosition(color: UIColor(hexString: "03A9F4"), size: CGSize(width:(self.window?.frame.size.width)!/2,height: (self.window?.frame.size.width)!/4), lineSize: CGSize(width:(self.window?.frame.size.width)!/2, height:2))
    
        return true
    }
}

