//
//  CountryCodeScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 13/02/2024.
//

import UIKit

protocol CountryCodeDelegate: AnyObject {
    func didSelectCountry(withCode code: String)
}

class CountryCodeScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var codeTableView: UITableView!
    
    weak var delegate: CountryCodeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        codeTableView.dataSource = self
        codeTableView.delegate = self
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else {
            fatalError("Unable to dequeue CountryTableViewCell")
        }

        let country = countries[indexPath.row]
        cell.countryNameLabel.text = country.name
        cell.countryCodeLabel.text = country.code
        
        // Add a disclosure indicator to the cell
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }


    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        delegate?.didSelectCountry(withCode: country.code)
        dismiss(animated: true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
}
