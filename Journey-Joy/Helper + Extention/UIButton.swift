//
//  UIButton.swift
//  Journey-Joy
//
//  Created by Maheen on 03/01/2024.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    convenience init(hexD8D8D8 alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(0xD8) / 255.0,
            green: CGFloat(0xD8) / 255.0,
            blue: CGFloat(0xD8) / 255.0,
            alpha: alpha
        )
    }
}


class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
//        setTitleColor(.white, for: .normal)
//        backgroundColor = .blue
//        layer.cornerRadius = 10
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        // Apply a highlighted tint color to the text when the button is tapped
        tintColor = .white

    }
}
