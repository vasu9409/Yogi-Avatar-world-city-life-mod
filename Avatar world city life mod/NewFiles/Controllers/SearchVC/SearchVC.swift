

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchVIewBG: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var originalData = ["John", "Emma", "Liam", "Olivia", "Sophia", "Search", "SearchSearch", "Search All"] // Sample data
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.searchTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        self.searchTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingDidBegin)
        self.searchTextField.text = "Search here..."
        self.searchVIewBG.layer.cornerRadius = IS_IPAD ? 42 : 24
        
        applyBlur(self.view,isBlack: false)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(for: "SearchCell")
        self.tableView.separatorStyle = .none
    }
    
    @objc func textFieldEditing() {
        if let searchText = self.searchTextField.text, !searchText.isEmpty {
            if searchText == "Search here..." {
                self.searchTextField.text = ""
                self.filteredData = self.originalData
                self.tableView.reloadData()
            }
        }
    }
    
    
    @objc func textFieldChange() {
        if let searchText = self.searchTextField.text, !searchText.isEmpty {
            self.filteredData = self.originalData.filter { $0.lowercased().contains(searchText.lowercased()) }
        } else {
            self.filteredData = self.originalData // If search is cleared, show all data
        }
        self.tableView.reloadData()
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.filteredData.isEmpty {
            return 1 // To show "No Results Found"
        }
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell  else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        if self.filteredData.isEmpty {
            cell.seachNameLabel.text = "No results is found"
           
        } else {
            cell.seachNameLabel.text = self.filteredData[indexPath.row]
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 82 : 52
    }
}
