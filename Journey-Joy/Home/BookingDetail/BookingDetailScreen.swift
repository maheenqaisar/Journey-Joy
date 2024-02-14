//
//  BookingDetailScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 02/02/2024.
//

import UIKit

class BookingDetailScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var paymenttableView: UITableView!
    @IBOutlet private weak var phoneaddedBtn: UIButton!
    
    let paymentData = ["Debit Card", "Credit Card", "JazzCash", "Easypaisa", "SadaPay", "NayaPay"]
    
    var selectedPaymentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymenttableView.delegate = self
        paymenttableView.dataSource = self
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymenttableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentTableViewCell

        cell.paymentLabel.text = paymentData[indexPath.row]

        // Configure circle image
        if indexPath.row == selectedPaymentIndex {
            cell.configureCircleImage()
        } else {
            cell.deselectCircleImage()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tableView.reloadData()
    }
    
    @IBAction func phoneAddedBtn(_ sender: Any) {
         let nextScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhoneNumberScreen") as! PhoneNumberScreen
         navigationController?.pushViewController(nextScreenVC, animated: true)
        updateButton()
     }
    
    func updateButton() {
        // Update your button here, change icon and color
        phoneaddedBtn.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        phoneaddedBtn.tintColor = .systemGreen
    }
}

class PaymentTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var circleImageView: UIImageView!

    // Method to configure the circle image based on the selected state
    func configureCircleImage() {
        circleImageView.image = UIImage(systemName: "circle.dashed.inset.filled")
    }

    // Method to deselect the circle image
    func deselectCircleImage() {
        circleImageView.image = UIImage(systemName: "circle")
    }
}
