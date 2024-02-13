//
//  alert.swift
//  SideMenu
//
//  Created by rana ehtisham on 7/25/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

/// Function to show  UiViewController
extension UIViewController {
    
    func alertMessage(userMessage : String) {
        let myAlert = UIAlertController(title: "Alert", message:userMessage, preferredStyle: .alert);
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated : true , completion : nil);
    }
    
}
