//
//  LoginVC.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit
import XMPPFramework

class LoginVC: UIViewController {

    
    @IBOutlet weak var logoImage         : UIImageView!
    @IBOutlet weak var _singInVIew       : UIView!
    @IBOutlet weak var signInButton      : UIButton!
    @IBOutlet weak var welcomeLabel      : UILabel!
    @IBOutlet weak var centerLineView    : UIView!
    @IBOutlet weak var jidTextField      : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!

    var xmppController: XMPPController!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView(){
        self.navigationController?.navigationBar.isHidden = true
        _singInVIew.layer.cornerRadius = 10
        _singInVIew.layer.borderColor = UIColor.systemGray5.cgColor
        _singInVIew.layer.borderWidth = 0.5
        centerLineView.backgroundColor = UIColor.systemGray5
        signInButton.addTarget(self, action: #selector(loginToApp), for: .touchUpInside)
        
        // WELCOME NOTE
        
        let attributedStr = NSMutableAttributedString()
        let welcomeFont =  UIFont.preferredFont(for: .title1, weight: .heavy)
        let signInFont =  UIFont.preferredFont(for: .footnote, weight: .medium)

        let WelcomeText = CommonCode.shared.getAttributedString(text: "Welcome Back\n", attributes: [.font: welcomeFont, .foregroundColor: UIColor.label])
        let signInText = CommonCode.shared.getAttributedString(text: "  Sign in to continue", attributes: [.font: signInFont, .foregroundColor: UIColor.systemGray])

        attributedStr.append(WelcomeText)
        attributedStr.append(signInText)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.attributedText = attributedStr
        welcomeLabel.textAlignment = .center
        signInButton.layer.cornerRadius = 5
        signInButton.backgroundColor = UIColor().AppTheme
        
    }

    
    @objc func loginToApp(){
        xmppConnection(userJID: "joiint-0@stun.joiint.com", userPassword: "joiint", server: "stun.joiint.com")
    }
    
}

extension LoginVC {

    func xmppConnection(userJID: String, userPassword: String, server: String) {

        do {
            try self.xmppController = XMPPController(hostName: server,userJIDString: userJID,password: userPassword)
            
            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.xmppController.connect()
        } catch {
            //Failed: "Something went wrong"
        }
    }
}

extension LoginVC: XMPPStreamDelegate {

    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        // Success
        let vc = CitiesVC()
        let nav = UINavigationController(rootViewController: vc)
        CommonCode.shared.switchRootViewController(rootViewController: nav)
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        // Failed: "Wrong password or username"
    }
    
}
