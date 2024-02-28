//
//  ReservationScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 28/02/2024.
//

import UIKit

class ReservationScreen: UIViewController {

    @IBOutlet weak var reservationView: UIView!
    @IBOutlet weak var gettingView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var hostView: UIView!
    
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var provideView: UIView!
    @IBOutlet weak var whereView: UIView!
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBorders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
    }

    
    // MARK: - Setup
    
    private func setupBorders() {
        let borderThickness: CGFloat = 6.0
        let thinBorderThickness: CGFloat = 2.0
        let borderColor = UIColor.systemGray6
        
        reservationView.addTopBorder(withColor: borderColor, thickness: borderThickness)
        gettingView.addTopBorder(withColor: borderColor, thickness: borderThickness)
        aboutView.addTopBorder(withColor: borderColor, thickness: borderThickness)
        paymentView.addTopBorder(withColor: borderColor, thickness: borderThickness)
        contactView.addTopBorder(withColor: borderColor, thickness: borderThickness)
        hostView.addTopBorder(withColor: borderColor, thickness: borderThickness)
        
        codeView.addTopBorder(withColor: borderColor, thickness: thinBorderThickness)
        cancelView.addTopBorder(withColor: borderColor, thickness: thinBorderThickness)
        directionView.addTopBorder(withColor: borderColor, thickness: thinBorderThickness)
        detailView.addTopBorder(withColor: borderColor, thickness: thinBorderThickness)
        provideView.addTopBorder(withColor: borderColor, thickness: thinBorderThickness)
        whereView.addTopBorder(withColor: borderColor, thickness: thinBorderThickness)
    }
    
    @IBAction func previousBackBtn(_ sender: UIBarButtonItem) {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
