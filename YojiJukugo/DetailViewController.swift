import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchTopButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}