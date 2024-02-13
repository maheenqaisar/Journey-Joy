//
//  TabBarScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 03/01/2024.
//

import UIKit

class TabBarScreen: UITabBarController {

    private var curveShapeLayer = CAShapeLayer()
    private var smallCircleLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTabBar()
        addLayers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCurvePath()

        // Set the first tab as active after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [weak self] in
            self?.selectedIndex = 0
        }
    }

    private func customizeTabBar() {
        tabBar.tintColor =  UIColor(hex: 0xD40050)
        tabBar.backgroundColor = .clear
        tabBar.clipsToBounds = false // Allow the shadow to be visible outside the tabBar bounds
        tabBar.layer.cornerRadius = 20
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.clear.cgColor

        // Remove the shadow from the tabBar.layer and add it directly to the view's layer
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 2

        // Bring the tabBar to the front to ensure it's above the shadow
        view.bringSubviewToFront(tabBar)
    }

    private func addLayers() {
        tabBar.layer.insertSublayer(curveShapeLayer, at: 0)

        smallCircleLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        smallCircleLayer.cornerRadius = 5
        smallCircleLayer.backgroundColor = UIColor(hex: 0xD40050).cgColor
        tabBar.layer.addSublayer(smallCircleLayer)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateCurvePath()
    }

    private func updateCurvePath() {
        guard let selectedItem = tabBar.selectedItem else {
            return
        }

        let tabIndex = tabBar.items?.firstIndex(of: selectedItem) ?? 0
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
        let midX = itemWidth * CGFloat(tabIndex) + itemWidth / 2

        let curvePath = createCurvePath(at: midX)
        curveShapeLayer.path = curvePath.cgPath
        curveShapeLayer.fillColor = UIColor.systemBackground.cgColor

        let centerY = tabBar.frame.height / 2 - 45
        smallCircleLayer.position = CGPoint(x: midX, y: centerY)

        addBounceAnimation()
    }

    private func addBounceAnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.2, 0.9, 1.15, 0.95, 1.0]
        bounceAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        bounceAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]
        bounceAnimation.duration = 0.5

        smallCircleLayer.add(bounceAnimation, forKey: "bounceAnimation")
    }

    private func createCurvePath(at midX: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()

        // Move to the top-left corner with corner radius
        path.move(to: CGPoint(x: 0, y: 0))

        // Draw a line to the top-right corner with corner radius
        path.addLine(to: CGPoint(x: tabBar.frame.width - 0, y: 0))

        // Add curve to the right corner
        path.addCurve(to: CGPoint(x: tabBar.frame.width, y: 10),
                      controlPoint1: CGPoint(x: tabBar.frame.width - 5, y: 0),
                      controlPoint2: CGPoint(x: tabBar.frame.width, y: 5))

        // Draw a line to the bottom-right corner
        path.addLine(to: CGPoint(x: tabBar.frame.width, y: tabBar.frame.height))

        // Draw a line to the bottom-left corner
        path.addLine(to: CGPoint(x: 0, y: tabBar.frame.height))

        // Add curve to the left corner
        path.addCurve(to: CGPoint(x: 0, y: 10),
                      controlPoint1: CGPoint(x: 0, y: 5),
                      controlPoint2: CGPoint(x: 5, y: 0))

        // Move to the starting point of the curve
        path.move(to: CGPoint(x: midX - 35, y: 0))

        // Adjust the control points for a deeper curve
        path.addCurve(to: CGPoint(x: midX + 35, y: 0),
                      controlPoint1: CGPoint(x: midX - 5, y: 25),
                      controlPoint2: CGPoint(x: midX + 5, y: 25))

        return path
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let newTabBarHeight: CGFloat = 105
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = newTabBarHeight
        tabBarFrame.origin.y = view.frame.height - newTabBarHeight
        tabBar.frame = tabBarFrame
    }
}
