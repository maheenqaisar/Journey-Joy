//
//  Show Tost.swift
//  DownTown Slice
//
//  Created by rana ehtisham on 9/13/19.
//  Copyright © 2019 tektiks inovation. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {
    
    func showToast(message : String) {
        
        
        var height:CGFloat!
        
        if hasSafeArea{
            height = self.view.frame.size.height - 80
        }else{
            height = self.view.frame.size.height - 45
        }
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: height, width: 300, height: 35))
        
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
