//
//  LinearProgressView.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 13/10/24.
//

import Foundation
import UIKit

class LinearProgressBar: UIView {

    private let progressLayer = CALayer()
    private let borderLayer = CAShapeLayer()
     let percentageLabel = UILabel()

    var progress: CGFloat = 0 {
        didSet {
            updateProgressBar()
        }
    }

    var barColor: UIColor = .systemBlue {
        didSet {
            progressLayer.backgroundColor = barColor.cgColor
        }
    }

    var borderColor: UIColor = .black {
        didSet {
            borderLayer.strokeColor = borderColor.cgColor
        }
    }

    var borderWidth: CGFloat = 2 {
        didSet {
            borderLayer.lineWidth = borderWidth
            layoutSubviews()
        }
    }

    var spacing: CGFloat = 5
    var innerSpacing: CGFloat = 8  // Additional space between border and progress bar

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Configure progressLayer
        progressLayer.backgroundColor = barColor.cgColor
        layer.addSublayer(progressLayer)

        // Configure borderLayer
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = borderWidth
        layer.addSublayer(borderLayer)

        // Configure percentageLabel
        percentageLabel.textAlignment = .center
        percentageLabel.textColor = .black
        addSubview(percentageLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Update borderLayer frame and path
        let outerRect = bounds.insetBy(dx: spacing, dy: spacing)
        let path = UIBezierPath(rect: outerRect)
        borderLayer.path = path.cgPath
        borderLayer.frame = bounds

        // Update percentageLabel frame
        percentageLabel.frame = bounds

        updateProgressBar()
    }

    private func updateProgressBar() {
        let outerRect = bounds.insetBy(dx: spacing, dy: spacing)
        let innerRect = outerRect.insetBy(dx: innerSpacing, dy: innerSpacing) // Inner spacing added here
        let progressWidth = innerRect.width * progress
        progressLayer.frame = CGRect(x: innerRect.origin.x, y: innerRect.origin.y, width: progressWidth, height: innerRect.height)

        // Update percentageLabel text
        let percentage = Int(progress * 100)
        percentageLabel.text = "\(percentage)%"
    }
}

