//
//  StatusBarColor.swift
//  DownTown Slice
//
//  Created by Muhammad Talha on 13/09/2019.
//  Copyright © 2019 tektiks inovation. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
      if responds(to: Selector(("statusBar"))) {
          return value(forKey: "statusBar") as? UIView
      } else {
          return nil
      }
    }
}

func changeStatusBarColor(view: UIView, color: UIColor) {
    if #available(iOS 13.0, *) {
        guard let statusBarManager = view.window?.windowScene?.statusBarManager else {
            return
        }
        
        let statusBarView = UIView()
        statusBarView.backgroundColor = color
        view.addSubview(statusBarView)
      
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.heightAnchor.constraint(equalToConstant: statusBarManager.statusBarFrame.height).isActive = true
        statusBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    } else {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = color
    }
}
