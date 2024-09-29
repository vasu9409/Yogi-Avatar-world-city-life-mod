//
//  SearchView.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

final class SearchView_AW: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    private var searchController: UISearchController!
    private var filteredData: [ListDTO_AW] = []
    
    var dismissCompletion: ((ListDTO_AW) -> Void) = { _ in }
    
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
    
    
    private func setupTableView_AW() {
       
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.addBorder_AW(color: Colors_AW.contentBorderColor, width: 2)
        tableView.rowHeight = self.iPad ? 55 : 40
        tableView.register_AW(cell: FilterViewTableViewCell_AW.self)
        tableView.roundCorners_AW(radius: 20)
    }
    
    func configure_AW(filteredData: [ListDTO_AW], actionHandler: @escaping ((ListDTO_AW) -> Void)) {
       
        
        self.filteredData = filteredData
        self.dismissCompletion = actionHandler
        self.tableView.reloadData()
    }
}

extension SearchView_AW: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell_AW(ofType: FilterViewTableViewCell_AW.self, at: indexPath)
        cell.titleLabel?.text = filteredData[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = filteredData[indexPath.row]
        dismissCompletion(content)
    }
}
