import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchGameButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "QuizView")
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    @IBAction func touchStudyButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Study", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "ListView")
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

