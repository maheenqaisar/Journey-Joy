//
//  DirectionView.swift
//  Journey-Joy
//
//  Created by Maheen on 28/02/2024.
//

import UIKit

class DirectionView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Data source for table view
    let dataArray: [(UIImage, String)] = [(#imageLiteral(resourceName: "Vector"), "Dummy Text"),
                                          (#imageLiteral(resourceName: "Vector"), "Dummy Text"),
                                          (#imageLiteral(resourceName: "Vector"), "Dummy Text"),
                                          (#imageLiteral(resourceName: "Vector"), "Dummy Text")]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionDetailViewCell", for: indexPath) as! DirectionDetailViewCell
        
        let (image, title) = dataArray[indexPath.row]
        cell.customImageView.image = image
        cell.customLabel.text = title
        
        return cell
    }
}

class DirectionDetailViewCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Create a custom disclosure indicator
        let disclosureImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        disclosureImageView.tintColor = .black
        accessoryView = disclosureImageView
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 2))
        separator.backgroundColor = UIColor.systemGray6
        self.addSubview(separator)
    }
}
