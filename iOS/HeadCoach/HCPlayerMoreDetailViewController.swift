
import Foundation
import UIKit
import SnapKit
import Alamofire

class HCPlayerMoreDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var player: FDPlayer!
    var detail: PlayerDetailView!
    @IBOutlet var playerImage: UIImageView!
    var header: UIView!
    var nameLabel: UILabel!
    var teamLabel: UILabel!
    var textContainer: UIView!
    var table: UITableView!
    var games = [Game]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        detail = PlayerDetailView(frame: view.bounds)
        view.addSubview(detail)
        detail.addCustomView()
        detail.setPlayer(player)
        detail.tempTradeButton.addTarget(self, action: #selector(HCPlayerMoreDetailController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
//        sendDataRequest()
    }
    
    func sendDataRequest(){
        for index in 0...4{
            let headers = ["Ocp-Apim-Subscription-Key" : "fa953b83a78d44a1b054b0afbbdff57e"]
            let url = "http://api.fantasydata.net/nfl/v2/JSON/PlayerGameStatsByPlayerID/2015REG/" + String(index) + "/" + String(player?.id)
            Alamofire.request(.GET, url, headers: headers)
                .responseJSON{response in switch response.result {
                case .Success(let JSON):
                    
                    let data = JSON as! NSDictionary
                    
                    let game = Game(week: data.objectForKey("Week") as! Int, opp: data.objectForKey("Opponent") as! String, homeOrAway: data.objectForKey("HomeOrAway") as! String, passYds: data.objectForKey("PassingYards") as! Int, recYds: data.objectForKey("ReceivingYards") as! Int)
                    self.games.append(game)
                    self.setUpTableView()
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    }
            }
        }
    }
    
    func buttonClicked(sender: AnyObject?) {
        if sender === detail.tempTradeButton {
            let vc = HCTradeDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setUpTableView(){
        detail.table.registerClass(GameTableViewDetail.self, forCellReuseIdentifier: "BasicCell")
        detail.table.delegate = self
        detail.table.dataSource = self
        detail.table.setNeedsLayout()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell") as! GameTableViewDetail
        cell.game = games[indexPath.row]
        cell.setNeedsLayout()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
}