//
//  UIView.swift
//  Journey-Joy
//
//  Created by Maheen on 10/01/2024.
//

import UIKit

//extension UIView {
//    func addTopBorder(withColor color: UIColor, thickness: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
//        self.layer.addSublayer(border)
//    }
//}

extension UIView {
    func addTopBorder(withColor color: UIColor, thickness: CGFloat) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: self.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: thickness)
        ])
    }
    
    func addBottomBorder(withColor color: UIColor, thickness: CGFloat) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: thickness)
        ])
    }
}
