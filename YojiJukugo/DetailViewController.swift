import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var meaningField: UITextView!
    
    var character: String?
    var reading: String?
    var meaning: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterLabel.text = character
        readingLabel.text = reading
        meaningField.text = meaning
    }
    
    @IBAction func touchTopButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
