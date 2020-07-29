import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var jukugoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var jukugoArray:[YojiJukugo] = []
    var displayArray: [YojiJukugo] = []
    var searchType = "部分一致"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jukugoTableView.delegate = self
        
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        
        let filepath = Bundle.main.path(forResource: "JukugoData", ofType:"plist" )
        let plist = NSArray(contentsOfFile: filepath!) as! [NSDictionary]
        
        jukugoArray = plist.map{
            YojiJukugo(character: $0["character"] as! String,
                       reading: $0["reading"] as! String,
                       meaning: $0["meaning"] as! String)
        }
        
        displayArray = jukugoArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! JukugoCell
        cell.characterLabel.text = displayArray[indexPath.row].character
        cell.readingLabel.text = displayArray[indexPath.row].reading
        return cell
    }
    
    @IBAction func segumentChanged(_ sender: Any) {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        searchType = segmentedControl.titleForSegment(at: selectedIndex)!
        print(searchType)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text!
        if(searchText.isEmpty) {
            displayArray = jukugoArray
        } else {
            switch searchType{
            case "前方一致":
                displayArray = jukugoArray.filter{$0.character.hasPrefix(searchText) || $0.reading.hasPrefix(searchText)}
            case "後方一致":
                displayArray = jukugoArray.filter{$0.character.hasSuffix(searchText) || $0.reading.hasSuffix(searchText)}
            default:
                displayArray = jukugoArray.filter{$0.character.contains(searchText) || $0.reading.contains(searchText)}
            }
        }
        jukugoTableView.reloadData()
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        nextView.character = displayArray[indexPath.row].character
        nextView.reading = displayArray[indexPath.row].reading
        nextView.meaning = displayArray[indexPath.row].meaning
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
