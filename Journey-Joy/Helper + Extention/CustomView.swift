//
//  CustomView.swift
//  Journey-Joy
//
//  Created by Maheen on 12/02/2024.
//

import UIKit

class CustomView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSeparator()
    }
    
    private func addSeparator() {
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 6))
        separator.backgroundColor = UIColor.systemGroupedBackground
        self.addSubview(separator)
    }
}

extension UIView {
    @IBInspectable var topBorder: UIColor? {
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

    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addTopBorderWithColor(color: topBorder, width: newValue)
        }
    }

    @IBInspectable var rightBorder: UIColor? {
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

    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addRightBorderWithColor(color: rightBorder, width: newValue)
        }
    }

    @IBInspectable var bottomBorder: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            addBottomBorderWithColor(color: newValue, width: bottomBorderWidth)
        }
    }

    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addBottomBorderWithColor(color: bottomBorder, width: newValue)
        }
    }

    @IBInspectable var leftBorder: UIColor? {
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

    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            addLeftBorderWithColor(color: leftBorder, width: newValue)
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

    private func addBottomBorderWithColor(color: UIColor?, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
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
