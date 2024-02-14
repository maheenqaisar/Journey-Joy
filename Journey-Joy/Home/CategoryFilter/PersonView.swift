//
//  PersonView.swift
//  Journey-Joy
//
//  Created by Maheen on 19/01/2024.
//

import UIKit

class PersonView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var persontableView: UITableView!

    var itemsArray: [Item] = []
    let personCellIdentifier = "PersonCell"
    var totalNumberUpdateHandler: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsArray = [
            Item(value: 0, title: "Male", subtitle: "Age 13 or above"),
            Item(value: 0, title: "Female", subtitle: "Age 13 or above"),
            Item(value: 0, title: "Children", subtitle: "Age 5 - 12")
        ]
     
        persontableView.dataSource = self
        persontableView.delegate = self
        
        // Call the function to initially update the total number label
        updateTotalNumberLabel()
    }

    func updateTotalNumberLabel() {
        let totalNumber = itemsArray.reduce(0) { $0 + $1.value }
        totalNumberUpdateHandler?(totalNumber)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = persontableView.dequeueReusableCell(withIdentifier: personCellIdentifier, for: indexPath) as! PersonTableViewCell

        let item = itemsArray[indexPath.row]
        cell.updateNumberLabel(with: item.value)
        cell.title.text = item.title
        cell.subtitle.text = item.subtitle

        cell.plusButtonAction = { [weak self] in
            self?.plusButtonTapped(indexPath: indexPath)
        }
        cell.minusButtonAction = { [weak self] in
            self?.minusButtonTapped(indexPath: indexPath)
        }
        return cell
    }

    func plusButtonTapped(indexPath: IndexPath) {
        itemsArray[indexPath.row].value += 1
        updateTotalNumberLabel()
        persontableView.reloadRows(at: [indexPath], with: .none)
    }

    func minusButtonTapped(indexPath: IndexPath) {
        if itemsArray[indexPath.row].value > 0 {
            itemsArray[indexPath.row].value -= 1
            updateTotalNumberLabel()
            persontableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
