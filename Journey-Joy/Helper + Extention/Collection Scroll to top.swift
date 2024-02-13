//
//  Collection Scroll to top.swift
//  SideMenu
//
//  Created by rana ehtisham on 8/19/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func scrollToTop() {
       self.scrollToItem(at: IndexPath(row: 0, section: 0),
                                          at: .top,
                                          animated: false)
    }
   
}
