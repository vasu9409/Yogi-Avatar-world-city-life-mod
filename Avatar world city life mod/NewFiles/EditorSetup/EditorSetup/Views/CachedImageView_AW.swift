//
//  CachedImageView_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit
import PDFKit

class CachedImageView_AW: UIImageView {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    func getPdfImage_AW(with data: Data?) {
       
        guard
            let data = data,
            let provider: CGDataProvider = CGDataProvider(data: data as CFData),
            let pdfDoc: CGPDFDocument = CGPDFDocument(provider),
            let pdfPage: CGPDFPage = pdfDoc.page(at: 1)
        else {
            self.image = UIImage()
            return
        }

        let pageRect = pdfPage.getBoxRect(.trimBox)

        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.clear.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(pdfPage)
        }

        self.image = img
    }
    
 
}

