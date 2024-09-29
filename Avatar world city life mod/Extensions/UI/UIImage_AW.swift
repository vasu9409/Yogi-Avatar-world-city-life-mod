//
//  UIImage.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
typealias ImageExt = UIImage

extension ImageExt {
    func tinted_AW(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}
