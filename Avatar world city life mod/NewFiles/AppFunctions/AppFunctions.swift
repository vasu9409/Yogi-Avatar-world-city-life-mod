

import Foundation
import UIKit

func checkIsDarkMode() -> Bool {
    return UITraitCollection.current.userInterfaceStyle == .dark
}

func applyBlur(_ view: UIView, isBlack: Bool = true) {
    let blurEffectView = UIVisualEffectView()
    blurEffectView.frame = view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.blur.radius = 5
    blurEffectView.blur.tintColor = .clear
    view.backgroundColor = isBlack ? UIColor.black.withAlphaComponent(0.5) : .clear
    view.insertSubview(blurEffectView, at: 0)
}
