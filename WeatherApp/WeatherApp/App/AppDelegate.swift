//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CoreDataStack.shared.setup {}
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        CommonCode.shared.welcomeToApp()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        try? CoreDataStack.shared.mainContext.save()
    }


}

