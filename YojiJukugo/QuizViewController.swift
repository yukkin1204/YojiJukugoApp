import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    let manager: QuizManager = QuizManager()
    var score = 0
    var correctNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer1Button.titleLabel?.numberOfLines = 0
        answer1Button.layer.borderWidth = 0.5
        answer1Button.layer.cornerRadius = 5.0
        
        answer2Button.titleLabel?.numberOfLines = 0
        answer2Button.layer.borderWidth = 0.5
        answer2Button.layer.cornerRadius = 5.0
        
        answer3Button.titleLabel?.numberOfLines = 0
        answer3Button.layer.borderWidth = 0.5
        answer3Button.layer.cornerRadius = 5.0
        
        answer4Button.titleLabel?.numberOfLines = 0
        answer4Button.layer.borderWidth = 0.5
        answer4Button.layer.cornerRadius = 5.0

        self.loadQuiz()
    }
    
    func loadQuiz(){
        self.countLabel.text = "\(manager.currentIndex + 1) 問目"
        self.characterLabel.text = manager.a[manager.currentIndex].character
        
        correctNumber = Int.random(in: 1 ... 4)
        
        switch correctNumber{
        case 1:
            answer1Button.setTitle(manager.a[manager.currentIndex].meaning, for: .normal)
            answer2Button.setTitle(manager.b[manager.currentIndex * 3].meaning, for: .normal)
            answer3Button.setTitle(manager.b[manager.currentIndex * 3 + 1].meaning, for: .normal)
            answer4Button.setTitle(manager.b[manager.currentIndex * 3 + 2].meaning, for: .normal)
        case 2:
            answer1Button.setTitle(manager.b[manager.currentIndex * 3].meaning, for: .normal)
            answer2Button.setTitle(manager.a[manager.currentIndex].meaning, for: .normal)
            answer3Button.setTitle(manager.b[manager.currentIndex * 3 + 1].meaning, for: .normal)
            answer4Button.setTitle(manager.b[manager.currentIndex * 3 + 2].meaning, for: .normal)
        case 3:
            answer1Button.setTitle(manager.b[manager.currentIndex * 3].meaning, for: .normal)
            answer2Button.setTitle(manager.b[manager.currentIndex * 3 + 1].meaning, for: .normal)
            answer3Button.setTitle(manager.a[manager.currentIndex].meaning, for: .normal)
            answer4Button.setTitle(manager.b[manager.currentIndex * 3 + 2].meaning, for: .normal)
        default:
            answer1Button.setTitle(manager.b[manager.currentIndex * 3].meaning, for: .normal)
            answer2Button.setTitle(manager.b[manager.currentIndex * 3 + 1].meaning, for: .normal)
            answer3Button.setTitle(manager.b[manager.currentIndex * 3 + 2].meaning, for: .normal)
            answer4Button.setTitle(manager.a[manager.currentIndex].meaning, for: .normal)
        }
    }
    
    @IBAction func touchAnswer1Button(_ sender: Any) {
        answerQuiz(answer: 1)
        showNextQuiz()
    }
    
    @IBAction func touchAnswer2Button(_ sender: Any) {
        answerQuiz(answer: 2)
        showNextQuiz()
    }
    
    @IBAction func touchAnswer3Button(_ sender: Any) {
        answerQuiz(answer: 3)
        showNextQuiz()
    }
    
    @IBAction func touchAnswer4Button(_ sender: Any) {
        answerQuiz(answer: 4)
        showNextQuiz()
    }
    
    func answerQuiz(answer: Int){
        if(answer == correctNumber){
            score += 1
        }
    }
    
    func showNextQuiz(){
        self.manager.nextQuiz()
        switch manager.status{
        case .inAnswer:
            self.loadQuiz()
        case .done:
            let storyboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "ResultView") as! ResultViewController
            nextView.score = score
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
}
