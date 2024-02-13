//
//  WelcomeScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 04/12/2023.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToGuest(_ sender: Any) {
        if let guestController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GuestScreen") as? GuestScreen {
            self.navigationController?.pushViewController(guestController, animated: true)
        }
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        if let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as? LoginScreen {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }

}
