//
//  LoginScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 07/12/2023.
//

import UIKit

class LoginScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToOTP(_ sender: Any) {
        if let guestController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OTPScreen") as? OTPScreen {
            self.navigationController?.pushViewController(guestController, animated: true)
        }
    }
}
