//
//  CommonCode.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit

class CommonCode: NSObject {
    
    //MARK: Singleton
    static let shared = CommonCode()
    private override init() {}
    
    func switchRootViewController(rootViewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let window = appDelegate.window else { return }
        window.rootViewController = rootViewController
    }
    
    func welcomeToApp() {
        let vc = LoginVC()
        let nav = UINavigationController.init(rootViewController: vc)
        nav.navigationBar.tintColor       = UIColor.white
        nav.navigationBar.barTintColor = UIColor().AppTheme
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        switchRootViewController(rootViewController: nav)
    }
    
    
    func getAttributedString(text: String, attributes:[NSAttributedString.Key: Any]) -> NSAttributedString{
        var attributedString = NSAttributedString()
        let text = text
        let attributes = attributes
        attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
  
}


