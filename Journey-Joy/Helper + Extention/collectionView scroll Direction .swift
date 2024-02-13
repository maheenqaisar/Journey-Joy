//
//  collectionView scroll Direction .swift
//  SideMenu
//
//  Created by rana ehtisham on 7/26/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

func changeCollectionDirection(collection:UICollectionView){
    if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.scrollDirection = .vertical
    }
    
}
