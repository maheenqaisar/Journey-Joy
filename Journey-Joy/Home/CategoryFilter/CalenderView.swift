//
//  CalenderView.swift
//  Journey-Joy
//
//  Created by Maheen on 19/01/2024.
//

import UIKit

class CalenderView: UIViewController {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    var endDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
    }

    private func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline

        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // 1 is Sunday, 2 is Monday

        // Set the minimum date to today
        datePicker.minimumDate = Date()

        datePicker.calendar = calendar

        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        dateSelected()
    }


    @objc func dateSelected() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"

        endDate = datePicker.date

        if let endDate = endDate {
            lblDate.font = UIFont(name: "AvenirNext-Medium", size: 16)
            lblDate.text = dateFormatter.string(from: endDate)
            
            // Post notification when date is selected
            NotificationCenter.default.post(name: Notification.Name("SelectedDate"), object: nil, userInfo: ["selectedDate": endDate])
        } else {
            lblDate.font = UIFont(name: "AvenirNext-Medium", size: 16)
            lblDate.text = ""
        }
    }
}
