//
//  TourView.swift
//  Journey-Joy
//
//  Created by Maheen on 19/01/2024.
//

import UIKit

class TourView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let tourOptions = ["Mountain Bliss", "City Lights", "Coastal Retreat", "Desert Mirage", "River Adventure", "Cultural Fusion", "Heritage Trail", "Wildlife Safari", "Mango Delight", "Hidden Valleys"]
    
    private var filteredTourOptions: [String] = []
    
    private let tourCellIdentifier = "TourCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredTourOptions = tourOptions
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTourOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tourCellIdentifier, for: indexPath) as! TourTableViewCell
        cell.titleLabel.text = filteredTourOptions[indexPath.row]
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Notify FilterScreen about the selected tour option
        NotificationCenter.default.post(name: NSNotification.Name("SelectedTourOption"), object: nil, userInfo: ["selectedOption": filteredTourOptions[indexPath.row]])
    }
    
    // MARK: - Filter Data
    
    func filterContentForSearchText(_ searchText: String) {
        filteredTourOptions = searchText.isEmpty ? tourOptions : tourOptions.filter { $0.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
