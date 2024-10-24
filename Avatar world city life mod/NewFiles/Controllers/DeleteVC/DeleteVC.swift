

import UIKit
import RealmSwift

protocol DeleteVCDelegate: AnyObject {
    func didDelete()
}

class DeleteVC: UIViewController {

    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var titleMSGLabe: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var savedSkins: ListElementObject?
    
    var imageDataArray: [Data] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.titleBackView.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.titleBackView.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.cancelButton.clipsToBounds = true
        self.deleteButton.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.deleteButton.clipsToBounds = true
        
        applyBlur(self.view)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        self.didDelete()
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    func didDelete() {
        
        
        do {
            let realm = try Realm()
            
            // Find the object(s) with the matching title
            let objectsToDelete = realm.objects(ListElementObject.self).filter("title == %@", self.savedSkins?.title ?? "")
            
            // Perform deletion inside a write transaction
            try realm.write {
                realm.delete(objectsToDelete)
            }
            
            self.dismiss(animated: false)
        } catch {
            print("Error deleting data from Realm: \(error)")
            self.dismiss(animated: false)
        }

    }
}
