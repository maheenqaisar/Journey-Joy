//
//  OnboardingCell.swift
//  Journey-Joy
//
//  Created by Maheen on 04/12/2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = String(describing: OnboardingCell.self)

    // MARK: - Outlets

    @IBOutlet weak var SlideImage: UIImageView!
    @IBOutlet weak var SlideDescr: UILabel!
    @IBOutlet weak var SlideTitle: UILabel!

    // MARK: - Cell Setup

    func setup(_ slide: OnboardingSlide) {

        // MARK: Set Up Cell with Onboarding Slide Data

        SlideImage.image = slide.image
        SlideTitle.text = slide.title
        SlideDescr.text = slide.description
    }
}
