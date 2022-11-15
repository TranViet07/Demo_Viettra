//
//  LoginViewController.swift
//  Demo
//
//  Created by TRANVIET on 11/10/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        homeImage.layer.cornerRadius = 20
        
        Email.layer.cornerRadius = Email.frame.height/2
        Email.clipsToBounds = true
        
        Password.layer.cornerRadius = Password.frame.height/2
        Password.clipsToBounds = true
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        loginButton.clipsToBounds = true
        
        registerButton.layer.cornerRadius = registerButton.frame.height/2
        registerButton.clipsToBounds = true
        

    }
    
    @IBAction func LoginPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "myTabBar")

            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
    }
    
    @IBAction func RegisterPressed(_ sender: Any) {
    }
    
    @IBAction func HelpPressed(_ sender: Any) {
    }
}


