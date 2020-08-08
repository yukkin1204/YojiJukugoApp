import UIKit

class QuizManager{
    
    var a: [YojiJukugo] = []
    var b: [YojiJukugo] = []
    var currentIndex: Int
    
    enum Status{
        case inAnswer
        case done
    }
    var status: Status

    init(){
        let filepath = Bundle.main.path(forResource: "JukugoData", ofType:"plist" )
        let plist = NSArray(contentsOfFile: filepath!) as! [NSDictionary]
        
        let jukugoArray = plist.map{
            YojiJukugo(character: $0["character"] as! String,
                       reading: $0["reading"] as! String,
                       meaning: $0["meaning"] as! String)
        }
        
        var numbers: [Int] = []
        
        while numbers.count < 20{
            let number = Int.random(in: 0 ... jukugoArray.count - 1)
            if !numbers.contains(number){
                numbers.append(number)
            }
        }
        
        for i in 0 ... 19{
            if i % 4 == 0{
                self.a.append(jukugoArray[numbers[i]])
            }else{
                self.b.append(jukugoArray[numbers[i]])
            }
        }
        
        currentIndex = 0
        status = .inAnswer
    }
    
    func nextQuiz(){
        if currentIndex < a.count - 1{
            currentIndex += 1
        }else{
            status = .done
        }
    }
}
