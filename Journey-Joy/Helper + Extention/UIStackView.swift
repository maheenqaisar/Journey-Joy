//
//  UIStackView.swift
//  Journey-Joy
//
//  Created by Maheen on 26/01/2024.
//

import UIKit

extension UIStackView {
    @IBInspectable var topBorderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            addTopBorderWithColor(color: newValue, width: topBorderWidth)
        }
    }

    @IBInspectable override var topBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addTopBorderWithColor(color: topBorderColor, width: newValue)
        }
    }

    @IBInspectable var rightBorderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            addRightBorderWithColor(color: newValue, width: rightBorderWidth)
        }
    }

    @IBInspectable override var rightBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addRightBorderWithColor(color: rightBorderColor, width: newValue)
        }
    }

    @IBInspectable var bottomBorderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            addBottomBorderWithColor(color: newValue, width: bottomBorderWidth, padding: bottomPadding)
        }
    }

    @IBInspectable override var bottomBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addBottomBorderWithColor(color: bottomBorderColor, width: newValue, padding: bottomPadding)
        }
    }

    @IBInspectable var leftBorderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            addLeftBorderWithColor(color: newValue, width: leftBorderWidth)
        }
    }

    @IBInspectable override var leftBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addLeftBorderWithColor(color: leftBorderColor, width: newValue)
        }
    }

    @IBInspectable var bottomPadding: CGFloat {
        get {
            return 0.0
        }
        set {
            addBottomBorderWithColor(color: bottomBorderColor, width: bottomBorderWidth, padding: newValue)
        }
    }

    private func addTopBorderWithColor(color: UIColor?, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        border.opacity = 0.5 // Set the desired opacity value here
        layer.addSublayer(border)
    }

    private func addRightBorderWithColor(color: UIColor?, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        border.opacity = 0.5 // Set the desired opacity value here
        layer.addSublayer(border)
    }

    private func addBottomBorderWithColor(color: UIColor?, width: CGFloat, padding: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width - padding, width: self.frame.size.width, height: width)
        border.opacity = 0.3 // Set the desired opacity value here
        layer.addSublayer(border)
    }

    private func addLeftBorderWithColor(color: UIColor?, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        border.opacity = 0.5 // Set the desired opacity value here
        layer.addSublayer(border)
    }
}
