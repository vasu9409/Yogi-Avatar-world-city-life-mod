

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
        
        
        self.titleBackView.layer.cornerRadius = IS_IPAD ? 40 : 22
        self.titleBackView.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = IS_IPAD ? 40 : 22
        self.cancelButton.clipsToBounds = true
        self.deleteButton.layer.cornerRadius = IS_IPAD ? 40 : 22
        self.deleteButton.clipsToBounds = true
        
        self.titleMSGLabe.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        self.cancelButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 32 : 20, style: .Medium)
        self.deleteButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 32 : 20, style: .Medium)
        
        
        
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
