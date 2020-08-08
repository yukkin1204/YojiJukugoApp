import UIKit

class RuleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchStartButton(_ sender: Any) {
        let storyboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "QuizView")
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
