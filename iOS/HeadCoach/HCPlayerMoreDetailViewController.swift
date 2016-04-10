
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
        detail = PlayerDetailView()
        view.addSubview(detail)
        detail.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        detail.addCustomView()
        detail.setPlayer(player)
        detail.draftButton.addTarget(detail, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        requestPlayerStats(player.id)
//        requestGameData()
//        sendDataRequest()
    }
    
    func requestGameData(){
        self.detail.games = [Game]()
        for index in 0...20{
            let headers = ["Ocp-Apim-Subscription-Key" : "fa953b83a78d44a1b054b0afbbdff57e"]
            let url = "http://api.fantasydata.net/nfl/v2/JSON/PlayerGameStatsByPlayerID/2015/" + String(index) + "/" + String(player.id)
            print(url)
            Alamofire.request(.GET, url, headers: headers)
                .responseJSON{response in
                    do{
                        print(response)
                    }
                    switch response.result {
                case .Success(let JSON):
                    let data = JSON as! Dictionary<String, AnyObject>
                    
                    print(data)
                    
                    let game = Game(week: data["Week"] as! Int, opp: data["Opponenet"] as! String, homeOrAway: data["HomeOrAway"] as! String, passYds: data["PassingYards"] as! Int, passTds: data["PassingTouchdowns"] as! Int, passInts: data["PassingInterceptions"] as! Int, recYds: data["ReceivingYards"] as! Int, recTds: data["ReceivingTouchdowns"] as! Int, recInts: data["ReceivingInterceptions"] as! Int, rushYds: data["RushingYards"] as! Int, rushTds: data["RushingTouchdowns"] as! Int, score: 1, oppScore: 1, fg0to19: data["FieldGoalsMade0to19"] as! Int, fg20to29: data["FieldGoalsMade20to29"] as! Int, fg30to39: data["FieldGoalsMade30to39"] as! Int, fg40to49: data["FieldGoalsMade40to49"] as! Int, fg50plus: data["FieldGoalsMade50Plus"] as! Int, started: data["Started"] as! Int)
                    self.detail.games.append(game)
                    print("added game")
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    }
            }
        }
    }
    
    func requestPlayerStats(playerID: Int){
        HCFantasyDataProvider.sharedInstance.getPlayerStatsForPlayerID(playerID, handler: PlayerDetailView.setStatisticalData(detail))
    }
    
    func buttonClicked(sender: AnyObject?) {
        if sender === detail.draftButton {
            let vc = HCTradeDetailViewController()
            vc.player1 = player
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setUpTableView(){
        detail.gameTable.registerClass(GameTableViewDetail.self, forCellReuseIdentifier: "BasicCell")
        detail.gameTable.delegate = self
        detail.gameTable.dataSource = self
        detail.gameTable.setNeedsLayout()
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