

import UIKit

class DeleteVC: UIViewController {

    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var titleMSGLabe: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
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
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
    }
}
