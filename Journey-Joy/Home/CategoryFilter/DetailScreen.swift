//
//  DetailScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 25/01/2024.
//

import UIKit

class DetailScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // Sample data
    let detailTour: [DetailTour] = [
        DetailTour(title: "Hunza Haven & Attabad Adventure", subtitle: "By Adventure Hunters on Jan 18 - Jan 24", description: "1 Deluxe Bedroom with Mountain View", imageName: #imageLiteral(resourceName: "Area-One")),
        DetailTour(title: "Karimabad Kingdom & Ultar Sar Splendor", subtitle: "By Adventure Hunters on Jan 18 - Jan 24", description: "1 Deluxe Bedroom with Mountain View", imageName: #imageLiteral(resourceName: "Area-Three")),
        DetailTour(title: "Passu Confluence & Khunjerab Gateway", subtitle: "By Adventure Hunters on Jan 18 - Jan 24", description: "1 Deluxe Bedroom with Mountain View", imageName: #imageLiteral(resourceName: "Area-Two")),
        DetailTour(title: "Hunza Haven & Attabad Adventure", subtitle: "By Adventure Hunters on Jan 18 - Jan 24", description: "1 Deluxe Bedroom with Mountain View", imageName: #imageLiteral(resourceName: "Area-One")),
        DetailTour(title: "Karimabad Kingdom & Ultar Sar Splendor", subtitle: "By Adventure Hunters on Jan 18 - Jan 24", description: "1 Deluxe Bedroom with Mountain View", imageName: #imageLiteral(resourceName: "Area-Three")),
        DetailTour(title: "Passu Confluence & Khunjerab Gateway", subtitle: "By Adventure Hunters on Jan 18 - Jan 24", description: "1 Deluxe Bedroom with Mountain View", imageName: #imageLiteral(resourceName: "Area-Two"))
    ]

    @IBOutlet var detailCollectionView: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailTour.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell

        // Configure the cell with data
        let currentDetailTour = detailTour[indexPath.item]
        cell.titleLabel.text = currentDetailTour.title
        cell.subtitleLabel.text = currentDetailTour.subtitle
        cell.descriptionLabel.text = currentDetailTour.description
        cell.itemImageView.image = currentDetailTour.imageName // Use the UIImage directly

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDetailTour = detailTour[indexPath.item]

        // Assuming DetailViewController is the storyboard ID of your detail view controller
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainDetailScreen") as? MainDetailScreen {
            // Pass the selected data to the detail view controller
            detailViewController.detailTour = selectedDetailTour

            // Wrap the detail view controller in a navigation controller
            let navigationController = UINavigationController(rootViewController: detailViewController)

            // Set the presentation style to full screen
            navigationController.modalPresentationStyle = .fullScreen

            // Present the navigation controller
            self.present(navigationController, animated: true, completion: nil)
        }
    }


    @IBAction func gotobackfilter(_ sender: Any) {
        // Assuming FilterScreen is the storyboard ID of your FilterScreen ViewController
        if let filterScreen = self.storyboard?.instantiateViewController(withIdentifier: "FilterScreen") {
            //filterScreen.hidesBottomBarWhenPushed = true
            //filterScreen.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
        }
    }
}
