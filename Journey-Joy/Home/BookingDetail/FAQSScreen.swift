//
//  FAQSScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 21/02/2024.
//

import UIKit

class FAQSScreen: UIViewController {

    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var thirdContainerView: UIView!
    @IBOutlet weak var fourthContainerView: UIView!
    @IBOutlet weak var fifthContainerView: UIView!
    @IBOutlet weak var sixthContainerView: UIView!
    @IBOutlet weak var seventhContainerView: UIView!
    
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide all container views
        firstContainerView.isHidden = true
        secondContainerView.isHidden = true
        thirdContainerView.isHidden = true
        fourthContainerView.isHidden = true
        fifthContainerView.isHidden = true
        sixthContainerView.isHidden = true
        seventhContainerView.isHidden = true
        
        // Show only the selected container view
        switch selectedIndex {
        case 1:
            firstContainerView.isHidden = false
        case 2:
            secondContainerView.isHidden = false
        case 3:
            thirdContainerView.isHidden = false
        case 4:
            fourthContainerView.isHidden = false
        case 5:
            fifthContainerView.isHidden = false
        case 6:
            sixthContainerView.isHidden = false
        case 7:
            seventhContainerView.isHidden = false
        default:
            break
        }
    }

}
