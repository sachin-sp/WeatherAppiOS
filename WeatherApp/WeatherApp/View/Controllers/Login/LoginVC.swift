//
//  LoginVC.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit
import XMPPFramework

class LoginVC: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var logoImage         : UIImageView!
    @IBOutlet weak var _singInVIew       : UIView!
    @IBOutlet weak var signInButton      : UIButton!
    @IBOutlet weak var welcomeLabel      : UILabel!
    @IBOutlet weak var centerLineView    : UIView!
    @IBOutlet weak var jidTextField      : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    var activitiIndicator: UIActivityIndicatorView!

    var xmppController: XMPPController!
}

extension LoginVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        jidTextField.delegate = self
        passwordTextField.delegate = self
        
    }

    
    @objc func loginToApp(){
        let userJID = self.jidTextField.text ?? "" //joiint-0@stun.joiint.com
        let userPassword = self.passwordTextField.text ?? "" //joiint
        if userJID.isEmpty || userPassword.isEmpty { return }
        showLoader()
        xmppConnection(userJID: userJID, userPassword: userPassword, server: "stun.joiint.com")
    }
    
    func showLoader() {
        
        self.activitiIndicator = UIActivityIndicatorView(style: .medium)
        self.activitiIndicator.color = UIColor().AppTheme
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.activitiIndicator)
        
        activitiIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activitiIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        activitiIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activitiIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        activitiIndicator.startAnimating()
        view.addSubview(activitiIndicator)
        view.bringSubviewToFront(activitiIndicator)
        view.isUserInteractionEnabled = false
    }
    
    func removeLoader() {
        self.view.isUserInteractionEnabled = true
        self.activitiIndicator.removeFromSuperview()
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginVC {

    func xmppConnection(userJID: String, userPassword: String, server: String) {

        do {
            try self.xmppController = XMPPController(hostName: server,userJIDString: userJID,password: userPassword)
            
            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.xmppController.connect()
        } catch {
            removeLoader()
            showAlert(message: "Incorrect JID or Password")
            //Failed: "Something went wrong"
        }
    }
}

extension LoginVC: XMPPStreamDelegate {

    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        // Success
        removeLoader()
        let vc = CitiesVC()
        let nav = UINavigationController(rootViewController: vc)
        CommonCode.shared.switchRootViewController(rootViewController: nav)
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        removeLoader()
        showAlert(message: "Incorrect JID or Password")
        // Failed: "Wrong password or username"
    }
    
    func xmppStream(_ sender: XMPPStream, didReceiveError error: DDXMLElement) {
        removeLoader()
        showAlert(message: "Incorrect JID or Password")
    }
    
    func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        removeLoader()
        showAlert(message: message.description)
    }
}
