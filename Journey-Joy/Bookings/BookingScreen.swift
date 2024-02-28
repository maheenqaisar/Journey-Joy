//
//  BookingScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 03/01/2024.
//

import UIKit

class BookingScreen: UIViewController {
    
    @IBOutlet weak var tourMainImage: UIImageView!
    @IBOutlet weak var detailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyCornerRadius()
        // Add tap gesture recognizer to the detailView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(detailViewTapped))
        detailView.addGestureRecognizer(tapGesture)
    }
    
    @objc func detailViewTapped() {
        if let reservationVC = storyboard?.instantiateViewController(withIdentifier: "ReservationScreen") {
            navigationController?.pushViewController(reservationVC, animated: true)
        }
    }
    
    func applyCornerRadius() {
        // Apply corner radius to top left and top right corners
        let cornerRadius = tourMainImage.bounds.size.width * 0.07
        let maskPath = UIBezierPath(
            roundedRect: tourMainImage.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        tourMainImage.layer.mask = maskLayer
    }
}
