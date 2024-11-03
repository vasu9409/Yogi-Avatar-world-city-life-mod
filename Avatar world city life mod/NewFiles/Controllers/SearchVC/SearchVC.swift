

import UIKit

protocol SearchVCDelegate: AnyObject {
    
    func selectedFromSearch(mods: E8V?, houseMods: The8Ua8Onb?)
    
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchVIewBG: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: SearchVCDelegate?
    
    var modsFilteredData = [E8V]()
    var houseModsFilteredData = [The8Ua8Onb]()
    
    var modsFilterArray: [E8V] = []
    var houseModsFilterArray: [The8Ua8Onb] = []
    
    var isFromHouseMods: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.searchTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        self.searchTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingDidBegin)
        self.searchTextField.text = "Search here..."
        self.searchVIewBG.layer.cornerRadius = IS_IPAD ? 42 : 24
        
        self.searchTextField.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 30 : 20, style: .bold)
        
        applyBlur(self.view,isBlack: false)
        
        // Load initial data into the filter arrays to show all data initially
        self.modsFilteredData = self.modsFilterArray
        self.houseModsFilteredData = self.houseModsFilterArray
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
        
        if let searchText = self.searchTextField.text, searchText == "Search here..." {
            self.searchTextField.text = ""
            self.modsFilteredData = self.modsFilterArray
            self.houseModsFilteredData = self.houseModsFilterArray
            self.tableView.reloadData()
        }
    }
    
    
    @objc func textFieldChange() {
        guard let searchText = self.searchTextField.text, !searchText.isEmpty else {
            // Reset to all data if search text is empty
            self.modsFilteredData = self.modsFilterArray
            self.houseModsFilteredData = self.houseModsFilterArray
            self.tableView.reloadData()
            return
        }
        
        // Filter based on selected mode
        if self.isFromHouseMods {
            self.houseModsFilteredData = self.houseModsFilterArray.filter { mod in
                mod.title.lowercased().contains(searchText.lowercased())
            }
        } else {
            self.modsFilteredData = self.modsFilterArray.filter { mod in
                mod.title.lowercased().contains(searchText.lowercased())
            }
        }
        self.tableView.reloadData()
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFromHouseMods {
            return self.houseModsFilteredData.isEmpty ? 1 : self.houseModsFilteredData.count
        } else {
            return self.modsFilteredData.isEmpty ? 1 : self.modsFilteredData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        if self.isFromHouseMods {
            cell.seachNameLabel.text = self.houseModsFilteredData.isEmpty ? "No results found" : self.houseModsFilteredData[indexPath.row].title
        } else {
            cell.seachNameLabel.text = self.modsFilteredData.isEmpty ? "No results found" : self.modsFilteredData[indexPath.row].title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 82 : 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFromHouseMods {
            self.dismiss(animated: false) {
                self.delegate?.selectedFromSearch(mods: nil, houseMods: self.houseModsFilteredData[indexPath.row])
            }
            
        } else {
            self.dismiss(animated: false) {
                self.delegate?.selectedFromSearch(mods: self.modsFilteredData[indexPath.row], houseMods: nil)
            }
        }
    }
}
