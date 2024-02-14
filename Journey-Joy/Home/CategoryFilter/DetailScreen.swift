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
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MainDetailScreen") as? MainDetailScreen {
            detailViewController.detailTour = selectedDetailTour
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

    @IBAction func gotobackfilter(_ sender: Any) {
        // Assuming FilterScreen is the storyboard ID of your FilterScreen ViewController
        if self.storyboard?.instantiateViewController(withIdentifier: "FilterScreen") is FilterScreen {
            //filterScreen.hidesBottomBarWhenPushed = true
            //filterScreen.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
        }
    }
}
