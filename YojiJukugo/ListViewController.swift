import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var jukugoArray: [YojiJukugo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath = Bundle.main.path(forResource: "JukugoData", ofType:"plist" )
        let plist = NSArray(contentsOfFile: filepath!) as! [NSDictionary]
        
        jukugoArray = plist.map({
            YojiJukugo(character: $0["character"] as! String,
                       reading: $0["reading"] as! String,
                       meaning: $0["meaning"] as! String)
        })
    }
    
    @IBAction func touchDetailButton(_ sender: Any) {
        let storyboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "DetailView")
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jukugoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
