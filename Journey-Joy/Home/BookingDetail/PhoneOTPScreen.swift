//
//  PhoneOTPScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 13/02/2024.
//

import UIKit

class PhoneOTPScreen: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets

    @IBOutlet private weak var tf1: UITextField!
    @IBOutlet private weak var tf2: UITextField!
    @IBOutlet private weak var tf3: UITextField!
    @IBOutlet private weak var tf4: UITextField!
    @IBOutlet private weak var proceedButton: UIButton!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    weak var delegate: PhoneOTPScreenDelegate?
    var phoneNumber: String?
    var countryCode: String?
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFields()
        configureProceedButton()
        startTimer()
        
        if let phoneNumber = phoneNumber, let countryCode = countryCode {
            phoneNumberLabel.text = "Enter the code we sent over SMS \(countryCode) \(phoneNumber)"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tf1.becomeFirstResponder()
    }

    // MARK: - Private Methods

    private func setupTextFields() {
        let textFields = [tf1, tf2, tf3, tf4]
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

    private var timer: Timer?
    private var secondsRemaining = 30

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
    }

    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            let minutes = secondsRemaining / 60
            let seconds = secondsRemaining % 60
            timerBtn.setTitle(String(format: "%01d:%02d", minutes, seconds), for: .normal)
            secondsRemaining -= 1
        } else {
            timer?.invalidate()
            timerBtn.setTitle("Send Again", for: .normal)
            resendLbl.text = "Didn't get code?"
        }
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
    
    @IBAction private func nextProceed(_ sender: Any) {
        if let myNavigationController = navigationController {
            myNavigationController.popToRootViewController(animated: true)
            // Call delegate method to update button in BookingDetailScreen
            delegate?.didTapButtonInPhoneOTPScreen()
        }
    }
    
    // MARK: - Text Field Change

    @objc private func textDidChange(textField: UITextField) {
        guard let text = textField.text, text.utf16.count == 1 else {
            return
        }

        switch textField {
        case tf1:
            tf2.becomeFirstResponder()
        case tf2:
            tf3.becomeFirstResponder()
        case tf3:
            tf4.becomeFirstResponder()
        case tf4:
            tf4.resignFirstResponder()
            checkIfAllFieldsFilled()
        default:
            break
        }
    }

    private func checkIfAllFieldsFilled() {
        let allFieldsFilled = ![tf1, tf2, tf3, tf4].map { $0?.text?.isEmpty ?? true }.contains(true)
        updateProceedButtonAppearance(enabled: allFieldsFilled)
    }
}
