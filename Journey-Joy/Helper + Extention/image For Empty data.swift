//
//  image For Empty data.swift
//  SideMenu
//
//  Created by rana ehtisham on 7/29/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    func get_address_Empty_View(str1:String,str2:String,imageName:String,onView : UIView) -> UIView {
        
        
        
        var isNoStr1 = false
        
        if str1.count == 0{
            isNoStr1 = true
            
            
        }
        
        
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        _ = screenSize.height
        
        
        
        
        
        let dialougeView = UIView.init(frame: CGRect(x: 0 , y: 0 , width: screenWidth, height: 200))
        //     dialougeView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        dialougeView.center = onView.center
        //        let color = UIColor(red:0.78, green:0.96, blue:0.82, alpha:1.0)
        //        dialougeView.backgroundColor = color
        
        self.view.addSubview(dialougeView)
        
        
        //----------------------------------------------------------------------------
        
        
        
        let imageView  = UIImageView(frame: CGRect(x: 0 , y: 0, width: 107 , height: 115))
        
        
        imageView.center.x = self.view.center.x
        imageView.center.y = 25
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        dialougeView.addSubview(imageView)
        
        
        
        //  System Bold 16.0
        if isNoStr1 == false{
            
            
            let label = UILabel(frame: CGRect(x: 0, y : 85 , width: Int(screenWidth) , height: 25))
            
            label.center.x = self.view.center.x
            label.textAlignment = .center
            label.numberOfLines = 0
            
            label.font = UIFont.boldSystemFont(ofSize: 20.0)
            
            // label.textColor = UIColor.init(red: 0.205, green: 0.205, blue: 0.205, alpha: 0.5)
            label.text = str1
            label.textColor = .darkGray
            
            
            //  label.textColor = UIColor.init(red: 0.205, green: 0.205, blue: 0.205, alpha: 0.5)
            dialougeView.addSubview(label)
            
            
            //---------------------------------------------------------------------------------
        }
        
        
        
        return dialougeView
    }
    
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

