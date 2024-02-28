//
//  BrowseView.swift
//  Journey-Joy
//
//  Created by Maheen on 22/02/2024.
//

import UIKit

class BrowseView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tours = ["Hunza", "Murree", "Skardu"]
    let cellReuseIdentifier = "BrowseCell"
    
    @IBOutlet var browseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        browseView.addTopBorder(withColor: .systemGray6, thickness: 2.0)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BrowseTableViewCell
        cell.tourNameLabel.text = tours[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected tour: \(tours[indexPath.row])")
    }
}

class BrowseTableViewCell: UITableViewCell {
    @IBOutlet weak var tourNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1.2))
//        separator.backgroundColor = UIColor.opaqueSeparator
//        self.addSubview(separator)
//    }
}
