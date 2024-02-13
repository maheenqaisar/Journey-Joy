//
//  CategoryScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 01/01/2024.
//

import UIKit

class CategoryScreen: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var localBtn: UIButton!
    @IBOutlet private weak var internationalBtn: UIButton!
    @IBOutlet private weak var proceedButton: UIButton!

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAppearance(localBtn)
        setupButtonAppearance(internationalBtn)
        updateProceedButtonAppearance(enabled: false)
    }

    // MARK: - Private Methods



    private func updateProceedButtonAppearance(enabled: Bool) {
        let customColor = UIColor(
            red: CGFloat(0xD4) / 255.0,
            green: CGFloat(0x00) / 255.0,
            blue: CGFloat(0x50) / 255.0,
            alpha: 1.0
        )

        proceedButton.isEnabled = enabled
        proceedButton.backgroundColor = enabled ? customColor : UIColor.secondarySystemBackground
        proceedButton.setTitleColor(enabled ? .white : .darkGray, for: .normal)
    }

    private func setupButtonAppearance(_ button: UIButton) {
        let unselectedColor = UIColor.systemGray6

        button.backgroundColor = unselectedColor
        button.setTitleColor(UIColor.lightGray, for: .normal)
    }

    private func updateButtonAppearance(selectedButton: UIButton, otherButton: UIButton) {
        let selectedColor = UIColor(
            red: CGFloat(0xD4) / 255.0,
            green: CGFloat(0x00) / 255.0,
            blue: CGFloat(0x50) / 255.0,
            alpha: 0.05
        )

        let borderColor = UIColor(
            red: CGFloat(0xD4) / 255.0,
            green: CGFloat(0x00) / 255.0,
            blue: CGFloat(0x50) / 255.0,
            alpha: 1.0
        )

        selectedButton.backgroundColor = selectedColor
        selectedButton.setTitleColor(UIColor( red: CGFloat(0xD4) / 255.0,
                                              green: CGFloat(0x00) / 255.0,
                                              blue: CGFloat(0x50) / 255.0,
                                              alpha: 1.0), for: .normal)
        selectedButton.layer.borderWidth = 0.6
        selectedButton.layer.borderColor = borderColor.cgColor

        otherButton.backgroundColor = UIColor.systemGray6
        otherButton.setTitleColor(UIColor.lightGray, for: .normal)
        otherButton.layer.borderWidth = 0.0 // No border for unselected button
        otherButton.layer.borderColor = nil // Clear border color
    }

    private func deselectButtons() {
        localBtn.isSelected = false
        internationalBtn.isSelected = false
        setupButtonAppearance(localBtn)
        setupButtonAppearance(internationalBtn)
    }

    // MARK: - Actions

    @IBAction private func localButtonTapped(_ sender: UIButton) {
        deselectButtons()
        localBtn.isSelected = true
        updateButtonAppearance(selectedButton: localBtn, otherButton: internationalBtn)
        updateProceedButtonAppearance(enabled: true)
    }

    @IBAction private func internationalButtonTapped(_ sender: UIButton) {
        deselectButtons()
        internationalBtn.isSelected = true
        updateButtonAppearance(selectedButton: internationalBtn, otherButton: localBtn)
        updateProceedButtonAppearance(enabled: true)
    }

    @IBAction private func proceedButtonTapped(_ sender: UIButton) {
        // Ensure only one button is selected
        guard localBtn.isSelected != internationalBtn.isSelected else {
            print("Must select one")
            return
        }

        let selectedButton = localBtn.isSelected ? localBtn : internationalBtn

        if localBtn.isSelected {
            // Handle local button selected
            print("Local button selected")
        } else {
            // Handle international button selected
            print("International button selected")
        }

        presentTabBarController(selectedButton!)
    }

    private func presentTabBarController(_ selectedButton: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "tabBar") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}
