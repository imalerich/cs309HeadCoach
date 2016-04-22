//
//  HCLiveGameViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class HCLiveGameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let sectionHeaders : [String] = ["Current Scores", "Quarterback", "Wide Reciever 1", "Wide Reciever 2",
        "Wide Reciever 3", "Runningback 1", "Runningback 2", "Tight End", "Kicker", "Defense / Special Teams"]
    var p1Scores : [Int] = [2, 5, 0, 3, 8, 1, 0, 3, 2]
    var p2Scores : [Int] = [0, 1, 3, 5, 5, 4, 1, 9, 2]
    
    var game: HCGameResult?
    
    let tableView = UITableView()
    
    var HCPlayerList: [HCPlayer]?
    var FDPlayerList: [FDPlayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change title of window
        self.title = "Live"
        
        // add chat button
        let chatButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(self.chatMethod))
        navigationItem.rightBarButtonItem = chatButton

        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LiveCell")
        
        HCPlayerList = [HCPlayer]()
        FDPlayerList = [FDPlayer]()
        HCHeadCoachDataProvider.sharedInstance.getAllPlayersForUserFromLeague(HCHeadCoachDataProvider.sharedInstance.league!, user: game!.users.0, completion: HCLiveGameViewController.onHDPlayerListResult(self))
        HCHeadCoachDataProvider.sharedInstance.getAllPlayersForUserFromLeague(HCHeadCoachDataProvider.sharedInstance.league!, user: game!.users.1, completion: HCLiveGameViewController.onHDPlayerListResult(self))
        
        
    }
    
    func onHDPlayerListResult(empty: Bool, players: [HCPlayer]){
        if !empty {
            for player in players{
                HCPlayerList?.append(player)
                HCFantasyDataProvider.sharedInstance.getFDPlayerFromHCPlayer(player, completion: HCLiveGameViewController.onFDPlayerResult(self))
                if FDPlayerList!.count > 0{
                    HCPlayerList!.sortInPlace({ (p1, p2) -> Bool in
                        getFDPlayerIndexForHCPlayer(p1) < getFDPlayerIndexForHCPlayer(p2)
                    })
                }
            }
        }
    }
    
    // method for performing live player chat actions
    func chatMethod(){
        print(HCRandomInsultGenerator.sharedInstance.generateInsult())]
    }
    
    func onFDPlayerResult(player: FDPlayer){
        FDPlayerList?.append(player)
        FDPlayerList?.sortInPlace({ (p1, p2) -> Bool in
            p1.age > p2.age
        })
        tableView.reloadData()
    }
    
    func getFDPlayerIndexForHCPlayer(player: HCPlayer) -> Int{
        for fdplayer in FDPlayerList!{
            if fdplayer.id == player.fantasy_id{
                return FDPlayerList!.indexOf({ (fdplayer) -> Bool in
                    return true
                })!
            }
            else{ return FDPlayerList!.count + 1 }
        }
        return FDPlayerList!.count + 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("LiveCell", forIndexPath: indexPath) as UITableViewCell!
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1,
                                   reuseIdentifier:"LiveCell")
        }
        cell.textLabel!.text = FDPlayerList?[indexPath.row].name
        cell.backgroundColor = HCPlayerList?[indexPath.row].user_id == game!.users.0.id ? UIColor.grayColor() : UIColor.lightGrayColor()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(section == 0){
//            return 2
//        }
        return (FDPlayerList?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if(indexPath.section == 0 && indexPath.row == 0){
//            return 60
//        }
        return 60
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Player List"
    }
}
