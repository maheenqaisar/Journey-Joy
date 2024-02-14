//
//  BookingMainScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 02/02/2024.
//

import UIKit

class BookingMainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedPaymentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        if indexPath.row == 0 {
            cell = configureFirstCell(for: indexPath)
        } else if indexPath.row == 1 {
            cell = configureSecondCell(for: indexPath)
        } else if indexPath.row == 2 {
            cell = configureThirdCell(for: indexPath)
        } else if indexPath.row == 3 {
            cell = configureFourthCell(for: indexPath)
        } else if indexPath.row == 4 {
            cell = configureFifthCell(for: indexPath)
        } else {
            cell = UITableViewCell()
        }

        cell.selectionStyle = .none
        return cell
    }

    // MARK: - Cell Configuration

    private func configureFirstCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCellIdentifier", for: indexPath) as! FirstTableViewCell
        return cell
    }

    private func configureSecondCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCellIdentifier", for: indexPath) as! SecondTableViewCell
        return cell
    }

    private func configureThirdCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCellIdentifier", for: indexPath) as! ThirdTableViewCell
        if indexPath.row == selectedPaymentIndex {
            cell.configureCircleImage()
        } else {
            cell.deselectCircleImage()
        }
        return cell
    }

    private func configureFourthCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FourthCellIdentifier", for: indexPath) as! FourthTableViewCell
        if indexPath.row == selectedPaymentIndex {
            cell.configureCircleImage()
        } else {
            cell.deselectCircleImage()
        }
        return cell
    }

    private func configureFifthCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FifthCellIdentifier", for: indexPath) as! FifthTableViewCell
        
        return cell
    }

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tableView.reloadData()
    }
    
    @IBAction func nextPayBtn(_ sender: Any) {
//        let nextScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingDetailScreen") as! BookingDetailScreen
//        navigationController?.pushViewController(nextScreenVC, animated: true)
//        
//        
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailScreen") as? BookingDetailScreen {
            let navigationController = UINavigationController(rootViewController: detailViewController)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.modalTransitionStyle = .crossDissolve
            self.present(navigationController, animated: true, completion: nil)
      
        }
    }
    
    @IBAction func gotoBack(_ sender: Any) {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

// MARK: - Cell Classes

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 6))
        separator.backgroundColor = UIColor.systemGroupedBackground
        self.addSubview(separator)
    }
}

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class ThirdTableViewCell: UITableViewCell {
    @IBOutlet weak var circleImageView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 6))
        separator.backgroundColor = UIColor.systemGroupedBackground
        self.addSubview(separator)
    }

    func configureCircleImage() {
        circleImageView.image = UIImage(systemName: "circle.dashed.inset.filled")
    }

    // Method to deselect the circle image
    func deselectCircleImage() {
        circleImageView.image = UIImage(systemName: "circle")
    }
}

class FourthTableViewCell: UITableViewCell {
    @IBOutlet weak var circleImageView: UIImageView!

    func configureCircleImage() {
        circleImageView.image = UIImage(systemName: "circle.dashed.inset.filled")
    }

    // Method to deselect the circle image
    func deselectCircleImage() {
        circleImageView.image = UIImage(systemName: "circle")
    }
}

class FifthTableViewCell: UITableViewCell {
    @IBOutlet weak var datelbl: UILabel!
}
