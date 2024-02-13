//
//  ForHideKeyboard.swift
//  SideMenu
//
//  Created by rana ehtisham on 7/26/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UITableView.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}



extension UICollectionView {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UITableView.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}




extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
