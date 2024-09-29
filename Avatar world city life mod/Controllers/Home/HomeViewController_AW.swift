//
//  HomeViewController.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

class HomeViewController_AW: BaseController_AW {
    
    @IBOutlet weak var filterContentView: FilterView_AW!
    @IBOutlet weak var searchContentView: SearchView_AW!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchLayerView: UIView!
    
    @IBOutlet weak var heightSearchView: NSLayoutConstraint!
    @IBOutlet weak var bottomTableConstraint: NSLayoutConstraint!
    
    private let clearButton: UIButton = UIButton(type: .custom)
    private var selectedModel: ListDTO_AW?
    private var loadingView = LoadingView_AW()
    private let viewModel: HouseIdeasContentModel_AW = HouseIdeasContentModel_AW()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        setupTableView_AW()
        setupUI_AW()
        bindData_AW()
        
        ReachabilityManager_AW.shared.isActiveInternet = { [weak self] in
            self?.loadingView.removeFromSuperview()
            self?.viewModel.checkContent_AW()
        }
        
        ReachabilityManager_AW.shared.completion = { [weak self] in
            self?.loadingView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkContent_AW()
        
        if let selectedModel = self.selectedModel {
            viewModel.makeSearch_AW(with: selectedModel)
        }
    }
    
    private func bindData_AW() {
        viewModel.onReload = { [weak self] in
            self?.tableView.reloadData()
            self?.loadingView.removeFromSuperview()
        }
        
        viewModel.showLoading_AW =  { [weak self] in
            self?.loadingView.removeFromSuperview()
            self?.showLoading_AW()
        }
    }
    
    private func setupUI_AW() {
        setupTheClearButton_AW()
        searchContentView.hide_AW()
        filterContentView.hide_AW()
        searchField.delegate = self
        searchContentView.backgroundColor = .clear
        bottomTableConstraint.constant = bottomInset()
        
        searchBgView.roundCorners_AW(radius: searchBgView.bounds.size.height / (iPad ? 2 : 2.2))
        searchBgView.addBorder_AW(color: .white, width: 1)
        
        searchLayerView.addBorder_AW(color: Colors_AW.contentBorderColor, width: 3)
        searchLayerView.roundCorners_AW(radius: searchLayerView.bounds.size.height / (iPad ? 2 : 2.2))
    }
    
    private func setupTableView_AW() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = self.iPad ? 500 : 330
        tableView.showsVerticalScrollIndicator = false
        tableView.register_AW(cell: ContentTableViewCell_AW.self)
    }
    
    private func setupTheClearButton_AW() {
        // Set up the clear button
        clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        clearButton.tintColor = .black
        
        clearButton.widthAnchor.constraint(equalToConstant: iPad ? 40 : 25).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: iPad ? 40 : 40).isActive = true
        clearButton.isHidden = true
        clearButton.addTarget(self, action: #selector(clearTextField_AW), for: .touchUpInside)
        
        // Add the clear button to the right view of the text field
        searchField.rightView = clearButton
        searchField.rightViewMode = .whileEditing
        
    }
    
    private func showLoading_AW() {
        loadingView = LoadingView_AW(frame: view.bounds)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            loadingView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height)
        ])
    }
    
    // Action for the clear button
    @objc func clearTextField_AW() {
        selectedModel = nil
        searchField.text = ""
        clearButton.isHidden = true
        self.view.endEditing(true)
        self.searchContentView.hide_AW()
//        viewModel.resetContent_AW()
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        if !filterContentView.isHidden {
            filterContentView.hide_AW()
            return
        }
        filterContentView.show_AW()
        searchContentView.hide_AW()
        hideSearch_AW()
        
        filterContentView.configure_AW { [weak self] filterAction in
            self?.clearTextField_AW()
            self?.viewModel.updateFilter_AW(with: filterAction)
            self?.filterContentView.hide_AW()
        }
    }
    
}

//MARK: - UITableViewDataSource -
extension HomeViewController_AW: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContentTableViewCell_AW = tableView.dequeueReusableCell_AW(ofType: ContentTableViewCell_AW.self, at: indexPath)
        cell.configure_AW(with: viewModel.content[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate -
extension HomeViewController_AW: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailContentViewController_AW()
        vc.model = viewModel.content[indexPath.row]
        vc.type = .houseIdeas
        vc.completionBack = { [weak self] model in
            guard let model = model else { return }
            self?.viewModel.checkUpdateModel_AW(with: model)
            if let selectedModel = self?.selectedModel {
                self?.viewModel.makeSearch_AW(with: selectedModel)
            }
        }
        filterContentView.hide_AW()
        searchContentView.hide_AW()
        clearTextField_AW()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController_AW: ContentTableViewCellDelegate_AW {
    func makeIsFavorite_AW(with model: ListDTO_AW) {
        self.viewModel.updateIsFavorites_AW(for: model)
        if let selectedModel = self.selectedModel {
            self.viewModel.makeSearch_AW(with: selectedModel)
        }
    }
}

extension HomeViewController_AW: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        clearButton.isHidden = searchText.isEmpty
        
        let filteredData = viewModel.originalContent.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false}
        
        if !searchText.isEmpty {
            searchContentView.show_AW()
            filterContentView.hide_AW()
            let height: CGFloat = self.iPad ? 55 : 40
            self.heightSearchView.constant = filteredData.count > 5 ? height * 5 : CGFloat(height * CGFloat(filteredData.count))
            searchContentView.configure_AW(filteredData: filteredData) { [weak self] selectedmodel in
                let vc = DetailContentViewController_AW()
                vc.model = selectedmodel
                vc.type = .houseIdeas
                vc.completionBack = { [weak self] model in
                    guard let model = model else { return }
                    self?.viewModel.checkUpdateModel_AW(with: model)
                    if let selectedModel = self?.selectedModel {
                        self?.viewModel.makeSearch_AW(with: selectedModel)
                    }
                }
                
                self?.filterContentView.hide_AW()
                self?.searchContentView.hide_AW()
                self?.clearTextField_AW()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            searchContentView.hide_AW()
            selectedModel = nil
            clearButton.isHidden = true
            viewModel.resetContent_AW()
        }
        
        return true
    }
    
    private func hideSearch_AW() {
        self.view.endEditing(true)
        self.searchContentView.hide_AW()
    }
}
