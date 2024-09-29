//
//  FilterView.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

enum FilterAction_AW: Int, CaseIterable {
    case all = 0
    case favorites
    case new
    case top

    var title: String {
        let key: String
        
        switch self {
        case .all:
            key = "All"
        case .favorites:
            key = "Favorites"
        case .new:
            key = "New"
        case .top:
            key = "Top"
        }
        
        return key
    }
    
    func isSelected(selectedFilter: FilterAction_AW) -> Bool {
            return self == selectedFilter
        }
    
}

final class FilterView_AW: UIView {
    @IBOutlet weak var tableView: UITableView!

    var dismissCompletion: ((FilterAction_AW) -> Void) = { _ in }
    private var selectedFilter: FilterAction_AW = .all
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        setupUI_AW()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         
        setupUI_AW()
    }
    
    
    private func setupUI_AW() {
        self.nibSetup_AW()
         
        setupTableView_AW()
    }
    
    func setSelectionFilter(selectedFilter: FilterAction_AW) {
        self.selectedFilter = selectedFilter
        self.tableView.reloadData()
    }
    
    private func setupTableView_AW() {
         
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.addBorder_AW(color: Colors_AW.contentBorderColor, width: 2)
        tableView.roundCorners_AW(radius: 20)
        tableView.register_AW(cell: FilterViewTableViewCell_AW.self)
    }
 
    func configure_AW(actionHandler: @escaping ((FilterAction_AW) -> Void)) {
         
        
        tableView.reloadData()
        self.dismissCompletion = actionHandler
    }
}

extension FilterView_AW: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return FilterAction_AW.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell_AW(ofType: FilterViewTableViewCell_AW.self, at: indexPath)
        let action = FilterAction_AW.allCases[indexPath.row]

        cell.backgroundColor = action.isSelected(selectedFilter: selectedFilter) ? .systemGray5 : .clear
        
        if indexPath.row == 3 {
            cell.separatorView.backgroundColor = .clear
        } else {
            cell.separatorView.backgroundColor = #colorLiteral(red: 0.999586165, green: 0.713522017, blue: 0.5051523447, alpha: 1)
        }
        cell.titleLabel?.text = action.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = FilterAction_AW.allCases[indexPath.row]
        self.selectedFilter = action
        tableView.reloadData()
        dismissCompletion(action)
    }
}

