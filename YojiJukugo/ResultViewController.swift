import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scoreLabel.text = "あなたのスコアは\(score)です。"
    }
    
    @IBAction func touchTopButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
