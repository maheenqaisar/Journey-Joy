//
//  PersonTableViewCell.swift
//  Journey-Joy
//
//  Created by Maheen on 24/01/2024.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    var plusButtonAction: (() -> Void)?
    var minusButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    @objc func plusButtonTapped() {
        plusButtonAction?()
    }
    
    @objc func minusButtonTapped() {
        minusButtonAction?()
    }
    
    func updateNumberLabel(with number: Int) {
        numberLabel.text = "\(number)"
        minusButton.isEnabled = (number > 0)
    }
}
