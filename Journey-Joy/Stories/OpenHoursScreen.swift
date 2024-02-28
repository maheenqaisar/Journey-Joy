//
//  OpenHoursScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 23/02/2024.
//

import UIKit

class OpenHoursScreen: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set the data source
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Reload data when view appears to update with the current day
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimingTableViewCell", for: indexPath) as! TimingTableViewCell
        
        // Configure the cell
        let currentDayIndex = getCurrentDayIndex()
        let dayIndex = indexPath.row
        
        cell.dayNameLabel.text = daysOfWeek[dayIndex]
        
        if dayIndex == currentDayIndex {
            if dayIndex == 0 { // Sunday
                cell.mainLabel.text = "Closed"
                cell.mainLabel.textColor = UIColor.red
            } else {
                cell.mainLabel.text = isBusinessOpen() ? "Open" : "Closed"
                cell.mainLabel.textColor = isBusinessOpen() ? UIColor.systemGreen : UIColor.red
            }
        } else {
            cell.mainLabel.text = "" // Clear label for other days
        }
        
        return cell
    }

    func isBusinessOpen() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.weekday, from: currentDate) - 1 // Adjust to match the daysOfWeek array indexing
        
        // Business is open on Monday to Friday
        return currentDay >= 1 && currentDay <= 5
    }
    
    func getCurrentDayIndex() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.weekday, from: currentDate) - 1 // Adjust to match the daysOfWeek array indexing
        return currentDay
    }
}


class TimingTableViewCell: UITableViewCell {
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
}
