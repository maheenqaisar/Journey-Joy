//
//  PhoneNumberScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 10/02/2024.
//

import UIKit

protocol PhoneOTPScreenDelegate: AnyObject {
    func didTapButtonInPhoneOTPScreen()
}

class PhoneNumberScreen: UIViewController, UITextFieldDelegate, PhoneOTPScreenDelegate {

    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var selectedCountryCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure your view
        updateCountryCodeButton()
        fieldUI()
        numberField.delegate = self
        updateNextButtonState()
    }
    
    func fieldUI() {
        numberField.borderStyle = .none
        numberField.backgroundColor = .clear
    }

    func updateCountryCodeButton() {
        if let selectedCountryCode = selectedCountryCode {
            countryCodeButton.setTitle(selectedCountryCode, for: .normal)
        } else {
            countryCodeButton.setTitle("+1", for: .normal)
        }
    }
    
    func didTapButtonInPhoneOTPScreen() {
        print("Button tapped on PhoneOTPScreen")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        // Allowing backspace
        if string == "" {
            return true
        }
        
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        let isValid = allowedCharacterSet.isSuperset(of: characterSet)
        
        // Limiting the total number of characters to 13
        let newLength = text.count + string.count - range.length
        let isValidLength = newLength <= 13
        
        updateNextButtonState(isValidLength: isValidLength)
        return isValid && isValidLength
    }

    @IBAction func countryCodeButtonTapped(_ sender: UIButton) {
        let countryCodeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryCodeScreen") as! CountryCodeScreen
        countryCodeVC.delegate = self
        countryCodeVC.modalPresentationStyle = .custom
        
        let navController = UINavigationController(rootViewController: countryCodeVC)
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let phoneNumber = numberField.text, let selectedCountryCode = selectedCountryCode else { return }
        let nextScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhoneOTPScreen") as! PhoneOTPScreen
        nextScreenVC.phoneNumber = phoneNumber
        nextScreenVC.countryCode = selectedCountryCode
        // Set self as delegate
        nextScreenVC.delegate = self
        navigationController?.pushViewController(nextScreenVC, animated: true)
    }
    
    func updateNextButtonState(isValidLength: Bool = false) {
        nextBtn.isEnabled = isValidLength
        if isValidLength {
            nextBtn.backgroundColor = UIColor(
                red: CGFloat(0xD4) / 255.0,
                green: CGFloat(0x00) / 255.0,
                blue: CGFloat(0x50) / 255.0,
                alpha: 1.0
            )
            nextBtn.setTitleColor(.white, for: .normal)
        } else {
            nextBtn.backgroundColor = UIColor.secondarySystemBackground
            nextBtn.setTitleColor(.black, for: .normal)
        }
    }
}

extension PhoneNumberScreen: CountryCodeDelegate {
    func didSelectCountry(withCode code: String) {
        selectedCountryCode = code
        updateCountryCodeButton()
    }
}
