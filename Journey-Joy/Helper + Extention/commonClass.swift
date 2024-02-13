//
//  commonClass.swift
//  SideMenu
//
//  Created by rana ehtisham on 7/14/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

class commonClass: NSObject {
    
    
    
    class func add_batchCount_tabbar(tabBarController : UITabBarController , Index : Int, count:Int)  {
        
        print("<<<  run add noti count   >>>>   ")
        
            tabBarController.tabBar.items?[Index].badgeValue = String(count)
        tabBarController.tabBar.items?[Index].setBadgeTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.darkText], for: .normal)
            
        } // func add batch count

}

