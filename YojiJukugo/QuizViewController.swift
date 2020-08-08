import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    let numberOfQuiz = 5
    var currentIndex = 0
    var score = 0

    var correctArray: [YojiJukugo] = []
    var wrongArray1: [YojiJukugo] = []
    var wrongArray2: [YojiJukugo] = []
    var wrongArray3: [YojiJukugo] = []

    var correctNumber = 0
    
    enum Status{
        case inAnswer
        case done
    }
    var status: Status = .inAnswer
    
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

        makeQuizzes()
        loadQuiz()
    }
    
    func makeQuizzes(){
        let filepath = Bundle.main.path(forResource: "JukugoData", ofType:"plist" )
        let plist = NSArray(contentsOfFile: filepath!) as! [NSDictionary]
        
        let jukugoArray = plist.map{
            YojiJukugo(character: $0["character"] as! String,
                       reading: $0["reading"] as! String,
                       meaning: $0["meaning"] as! String)
        }
        
        var numbers: [Int] = []
        
        while numbers.count < numberOfQuiz * 4{
            let number = Int.random(in: 0 ... jukugoArray.count - 1)
            if !numbers.contains(number){
                numbers.append(number)
            }
        }
        
        for i in 0 ... numberOfQuiz * 4 - 1{
            switch i % 4{
            case 0:
                correctArray.append(jukugoArray[numbers[i]])
            case 1:
                wrongArray1.append(jukugoArray[numbers[i]])
            case 2:
                wrongArray2.append(jukugoArray[numbers[i]])
            default:
                wrongArray3.append(jukugoArray[numbers[i]])
            }
        }
    }
    
    func loadQuiz(){
        self.countLabel.text = "\(currentIndex + 1) 問目"
        self.characterLabel.text = correctArray[currentIndex].character
        
        correctNumber = Int.random(in: 1 ... 4)
        
        switch correctNumber{
        case 1:
            answer1Button.setTitle(correctArray[currentIndex].meaning, for: .normal)
            answer2Button.setTitle(wrongArray1[currentIndex].meaning, for: .normal)
            answer3Button.setTitle(wrongArray2[currentIndex].meaning, for: .normal)
            answer4Button.setTitle(wrongArray3[currentIndex].meaning, for: .normal)
        case 2:
            answer1Button.setTitle(wrongArray1[currentIndex].meaning, for: .normal)
            answer2Button.setTitle(correctArray[currentIndex].meaning, for: .normal)
            answer3Button.setTitle(wrongArray2[currentIndex].meaning, for: .normal)
            answer4Button.setTitle(wrongArray3[currentIndex].meaning, for: .normal)
        case 3:
            answer1Button.setTitle(wrongArray1[currentIndex].meaning, for: .normal)
            answer2Button.setTitle(wrongArray2[currentIndex].meaning, for: .normal)
            answer3Button.setTitle(correctArray[currentIndex].meaning, for: .normal)
            answer4Button.setTitle(wrongArray3[currentIndex].meaning, for: .normal)
        default:
            answer1Button.setTitle(wrongArray1[currentIndex].meaning, for: .normal)
            answer2Button.setTitle(wrongArray2[currentIndex].meaning, for: .normal)
            answer3Button.setTitle(wrongArray3[currentIndex].meaning, for: .normal)
            answer4Button.setTitle(correctArray[currentIndex].meaning, for: .normal)
        }
    }
    
    @IBAction func touchAnswer1Button(_ sender: Any) {
        answerQuiz(answer: 1)
    }
    
    @IBAction func touchAnswer2Button(_ sender: Any) {
        answerQuiz(answer: 2)
    }
    
    @IBAction func touchAnswer3Button(_ sender: Any) {
        answerQuiz(answer: 3)
    }
    
    @IBAction func touchAnswer4Button(_ sender: Any) {
        answerQuiz(answer: 4)
    }
    
    func answerQuiz(answer: Int){
        if(answer == correctNumber){
            score += 1
        }
        showNextQuiz()
    }
    
    func showNextQuiz(){
        if currentIndex < numberOfQuiz - 1{
            currentIndex += 1
        }else{
            status = .done
        }
        
        switch status{
        case .inAnswer:
            loadQuiz()
        case .done:
            let storyboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "ResultView") as! ResultViewController
            nextView.score = score
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
}
