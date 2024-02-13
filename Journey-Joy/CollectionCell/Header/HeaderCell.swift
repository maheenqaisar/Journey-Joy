//
//  HeaderCell.swift
//  Journey-Joy
//
//  Created by Maheen on 10/01/2024.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    static let identifier = "HeaderCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    
    // MARK: - Cell Setup
    
    func setup(_ slide: HeaderSlide) {
        
        // MARK: Set Up Cell with Onboarding Slide Data
        
        slideImage.image = slide.image
        slideTitle.text = slide.title
    }
}
