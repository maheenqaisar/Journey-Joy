//
//  Dynamic Height.swift
//  SixApp
//
//  Created by Talha on 11/03/2021.
//

import Foundation
import UIKit

class DynamicHeight: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        print(contentSize)
        return contentSize
    }
    
}
