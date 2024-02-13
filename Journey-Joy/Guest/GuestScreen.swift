//
//  GuestScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 06/12/2023.
//

import UIKit

class GuestScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        if let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as? LoginScreen {
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }
    
}
