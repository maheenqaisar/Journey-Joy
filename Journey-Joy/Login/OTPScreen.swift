//
//  OTPScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 07/12/2023.
//

import UIKit

class OTPScreen: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets

    @IBOutlet private weak var otptf1: UITextField!
    @IBOutlet private weak var otptf2: UITextField!
    @IBOutlet private weak var otptf3: UITextField!
    @IBOutlet private weak var otptf4: UITextField!
    @IBOutlet private weak var proceedButton: UIButton!

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFields()
        configureProceedButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        otptf1.becomeFirstResponder()
    }

    // MARK: - Private Methods

    private func setupTextFields() {
        let textFields = [otptf1, otptf2, otptf3, otptf4]
        textFields.forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        }
    }

    private func configureProceedButton() {
        updateProceedButtonAppearance(enabled: false)
    }

    private func updateProceedButtonAppearance(enabled: Bool) {
        let customColor = UIColor(
            red: CGFloat(0xD4) / 255.0,
            green: CGFloat(0x00) / 255.0,
            blue: CGFloat(0x50) / 255.0,
            alpha: 1.0
        )
        
        proceedButton.isEnabled = enabled
        proceedButton.backgroundColor = enabled ? customColor : .secondarySystemBackground
        proceedButton.setTitleColor(enabled ? .white : .darkGray, for: .normal)
    }

    // MARK: - Text Field Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        if string.isEmpty {
            return true
        }
        guard allowedCharacterSet.isSuperset(of: characterSet) else {
            return false
        }
        
        // Limiting text field length to 1 character
        guard (textField.text?.count ?? 0) < 1 else {
            return false
        }
        
        return true
    }


    // MARK: - Actions

    @IBAction private func nextProceed(_ sender: Any) {
        if let guestController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryScreen") as? CategoryScreen {
            navigationController?.pushViewController(guestController, animated: true)
        }
    }

    // MARK: - Text Field Change

    @objc private func textDidChange(textField: UITextField) {
        guard let text = textField.text, text.utf16.count == 1 else {
            return
        }

        switch textField {
        case otptf1:
            otptf2.becomeFirstResponder()
        case otptf2:
            otptf3.becomeFirstResponder()
        case otptf3:
            otptf4.becomeFirstResponder()
        case otptf4:
            otptf4.resignFirstResponder()
            checkIfAllFieldsFilled()
        default:
            break
        }
    }

    private func checkIfAllFieldsFilled() {
        let allFieldsFilled = ![otptf1, otptf2, otptf3, otptf4].map { $0?.text?.isEmpty ?? true }.contains(true)
        updateProceedButtonAppearance(enabled: allFieldsFilled)
    }
}
