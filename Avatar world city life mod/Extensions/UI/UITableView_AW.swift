//
//  UITableView.swift
//  AI Voice changer
//
//  Created by Alex N
//

import Foundation
import UIKit

typealias TableView = UITableView
public extension TableView {
  

    func register_AW<T: UITableViewCell>(cell: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }

    func registerCellNib<T: Reusable_AW>(_ cellType: T.Type) where T: UITableViewCell {
        let nib = UINib(nibName: cellType.reuseID, bundle: Bundle(for: cellType))
        register(nib, forCellReuseIdentifier: cellType.reuseID)
    }

    func dequeueReusableCell_AW<T: Reusable_AW>(
        ofType cellType: T.Type,
        at indexPath: IndexPath
    ) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("❌ Failed attempt create reuse cell \(cellType.reuseID)")
        }
        return cell
    }
    
}

public protocol Reusable_AW {
    static var reuseID: String { get }
}

public extension Reusable_AW {
    static var reuseID: String {
        return String(describing: self)
    }
}
