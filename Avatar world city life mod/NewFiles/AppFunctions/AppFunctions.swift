

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

func calculateCellWidth(text: String, collectionView: UICollectionView) -> CGFloat {
    let label = UILabel()
    label.text = text
    label.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 30 : 20, style: .bold)
    label.sizeToFit()
    let cellWidth = label.frame.width + 50
    return cellWidth
}
