//
//  HomeScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 03/01/2024.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index: Int)
}

class CustomSegmentedControl: UIView {
    private var segmentData: [(title: String, icon: UIImage)]!
    private var buttons: [UIButton]!
    private var selectorView: UIView?

    var textColor: UIColor = .systemGray2
    var selectorTextColor: UIColor =  UIColor(hex: 0xD40050)
    var activeTintColor: UIColor = UIColor(hex: 0xD40050)

    weak var delegate: CustomSegmentedControlDelegate?

    var valueChangedHandler: ((Int) -> Void)?

    public private(set) var selectedIndex: Int = 0

    convenience init(frame: CGRect, segmentData: [(title: String, icon: UIImage)]) {
        self.init(frame: frame)
        self.segmentData = segmentData
        updateView()
    }

    func setSegmentData(segmentData: [(title: String, icon: UIImage)]) {
        self.segmentData = segmentData
        updateView()
    }

    func setIndex(index: Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width / CGFloat(segmentData.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView?.frame.origin.x = selectorPosition
        }
        updateActiveSegmentAppearance(index: selectedIndex)
    }

    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width / CGFloat(segmentData.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                valueChangedHandler?(selectedIndex)
                delegate?.change(to: selectedIndex)

                // Animate the selector view along with the title color change
                UIView.animate(withDuration: 0.3) {
                    self.selectorView?.frame.origin.x = selectorPosition
                }

                btn.setTitleColor(selectorTextColor, for: .normal)
                updateActiveSegmentAppearance(index: selectedIndex)
            }
        }
    }
}

extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        // Add border view
        let borderView = UIView()
        borderView.backgroundColor = .systemGray2
        stack.addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        borderView.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        borderView.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }


    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })

        let avinerNextMediumFont = UIFont(name: "AvenirNext-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)

        for (index, segment) in segmentData.enumerated() {
            let button = UIButton(type: .system)

            let imageView = UIImageView(image: segment.icon.withRenderingMode(.alwaysTemplate))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

            let titleLabel = UILabel()
            titleLabel.text = segment.title
            titleLabel.font = avinerNextMediumFont // Set the font here
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 5

            button.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true

            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)

            if let selectorView = selectorView {
                let selectorPosition = frame.width / CGFloat(segmentData.count) * CGFloat(index)
                button.addSubview(selectorView)
                selectorView.frame.origin.x = selectorPosition
            }
        }

        let mainStackView = UIStackView(arrangedSubviews: buttons)
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        addSubview(mainStackView)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        buttons.forEach { $0.setTitleColor(textColor, for: .normal) }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        updateActiveSegmentAppearance(index: selectedIndex)
    }

    private func updateActiveSegmentAppearance(index: Int) {
        for (buttonIndex, button) in buttons.enumerated() {
            if buttonIndex == index {
                let imageView = button.subviews.compactMap { $0 as? UIStackView }.first?.arrangedSubviews.first as? UIImageView
                let titleLabel = button.subviews.compactMap { $0 as? UIStackView }.first?.arrangedSubviews.last as? UILabel

                UIView.animate(withDuration: 0.3) { [self] in
                    imageView?.tintColor = activeTintColor
                    titleLabel?.textColor = activeTintColor
                }

                // Add bottom border line
                let bottomBorder = UIView()
                bottomBorder.backgroundColor = UIColor(hex: 0xD40050)
                bottomBorder.translatesAutoresizingMaskIntoConstraints = false
                button.addSubview(bottomBorder)
                NSLayoutConstraint.activate([
                    bottomBorder.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                    bottomBorder.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                    bottomBorder.bottomAnchor.constraint(equalTo: button.bottomAnchor),
                    bottomBorder.heightAnchor.constraint(equalToConstant: 3)
                ])
            } else {
                let imageView = button.subviews.compactMap { $0 as? UIStackView }.first?.arrangedSubviews.first as? UIImageView
                let titleLabel = button.subviews.compactMap { $0 as? UIStackView }.first?.arrangedSubviews.last as? UILabel

                UIView.animate(withDuration: 0.3) { [self] in
                    imageView?.tintColor = textColor
                    titleLabel?.textColor = textColor
                }
                
                // Remove any existing bottom border lines
                button.subviews.forEach { subview in
                    if subview.backgroundColor == UIColor(hex: 0xD40050) {
                        UIView.animate(withDuration: 0.3) {
                            subview.alpha = 0 // Fade out the border
                        } completion: { (_) in
                            subview.removeFromSuperview() // Remove after animation completes
                        }
                    }
                }
            }
        }
    }
}
