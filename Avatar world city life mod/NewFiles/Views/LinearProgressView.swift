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
    var cornerRadius: CGFloat = 10  // Corner radius for rounded corners

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

        // Apply corner radius to the view and ensure sublayers are clipped correctly
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        // Update borderLayer frame and path
        let outerRect = bounds.insetBy(dx: spacing, dy: spacing)
        let path = UIBezierPath(roundedRect: outerRect, cornerRadius: cornerRadius)
        borderLayer.path = path.cgPath
        borderLayer.frame = bounds
        borderLayer.cornerRadius = cornerRadius

        // Update percentageLabel frame
        percentageLabel.frame = bounds

        updateProgressBar()
    }

    private func updateProgressBar() {
        let outerRect = bounds.insetBy(dx: spacing, dy: spacing)
        let innerRect = outerRect.insetBy(dx: innerSpacing, dy: innerSpacing) // Inner spacing added here
        let progressWidth = innerRect.width * progress
        
        // Apply corner radius and update progress layer frame
        progressLayer.frame = CGRect(x: innerRect.origin.x, y: innerRect.origin.y, width: progressWidth, height: innerRect.height)
        progressLayer.cornerRadius = innerRect.height / 2 + 1
        progressLayer.masksToBounds = true

        // Update percentageLabel text
        let percentage = Int(progress * 100)
        percentageLabel.text = "\(percentage)%"

        // Change the label color if progress is more than 45%
        
        if progress > 0.49 {
            if progress > 0.51 {
                self.percentageLabel.textColor = UIColor(named: "whitedowncolorset")
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.percentageLabel.textColor = UIColor(named: "whitedowncolorset")
                }
            }
        } else {
            percentageLabel.textColor = UIColor(named: "newblackcolorfounded")
        }
        
    }
}
