//
//  HCPlayerDetailViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import RealmSwift
import ImageLoader

class HCPlayerDetailViewController: UIViewController, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var playerListView: PlayerListView = PlayerListView()
    
    var playerList: Results<(FDPlayer)> = try! Realm().objects(FDPlayer)
    var playerList2 : [(HCPlayer)] = []
    
    var temp : [(FDPlayer)] = []
    
    var players: [(HCPlayer)] = []
    var sortType: FDPlayer.SortType = FDPlayer.SortType.AlphaAZ
    var filterType: FDPlayer.PositionFilterType = FDPlayer.PositionFilterType.All
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(playerList.count == 0){
            HCFantasyDataProvider().getPlayerDetails(){(responseString: String?) in
                print(responseString)
            }
            playerList = try! Realm().objects(FDPlayer)
        }
        
        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.getUndraftedPlayersInLeague(dp.league!) { (error, players) in
            self.playerList2 = players
            self.playerListView.tableView.reloadData()
        }
        for player in playerList2{
            temp.append(try! Realm().objects(FDPlayer).filter("id == \(player.fantasy_id)").first!)
        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        playerListView = PlayerListView(frame: view.bounds, delegate: self)
        view.addSubview(playerListView)
        playerListView.filterButton.addTarget(self, action: #selector(HCPlayerDetailViewController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        playerListView.sortButton.addTarget(self, action: #selector(HCPlayerDetailViewController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        /*
        if(playerList.count==0){
            HCFantasyDataProvider.sharedInstance.getPlayerDetails(){(responseString:String?) in
                self.playerList = try! Realm().objects(FDPlayer)
                self.playerListView.addCustomView()
            }
        }else{
            playerListView.addCustomView()
        }
        */
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        for touch in (event?.touchesForWindow(self.view.window!))!{
            if(touch.locationInView(self.view).y < touch.previousLocationInView(self.view).y){
                playerListView.updateTopBar(isVisible: true)
                print("visible")
            }else{
                playerListView.updateTopBar(isVisible: false)
                print("invisible")
            }
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
    }
    
    func buttonClicked(sender: AnyObject?) {
        print("button clicked")
        if sender === playerListView.sortButton {
            print("sort button pressed")
            playerListView.showPicker(forDataSource: playerListView.pickerSortData)
        }else if sender === playerListView.filterButton{
            print("filter button pressed")
            playerListView.showPicker(forDataSource: playerListView.pickerFilterData)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        playerListView.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = HCPlayerMoreDetailController()
        vc.player = temp[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = playerListView.tableView.dequeueReusableCellWithIdentifier("BasicCell") as! PlayerTableViewCell
        cell.setPlayer(try! Realm().objects(FDPlayer).filter("id == \(players[indexPath.row].fantasy_id)").first!)
        cell.playerImage.load(temp[indexPath.row].photoURL)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func sortPlayers(type: FDPlayer.SortType) {
        sortType = type
        switch(type){
        case FDPlayer.SortType.AlphaAZ:
            temp = temp.sort({ (p1, p2) -> Bool in
                return p1.lastName < p2.lastName ? true : false
            })
        case FDPlayer.SortType.AlphaZA:
            temp = temp.sort({ (p1, p2) -> Bool in
                return p1.lastName < p2.lastName ? false : true
            })
        }
        playerListView.tableView.reloadData();
        playerListView.updateButtonText(sortType, filterType: filterType)
    }
    
    func filterPlayer(type: FDPlayer.PositionFilterType){
        filterType = type
        switch(type){
        case FDPlayer.PositionFilterType.All:
            temp = temp.filter({ (p) -> Bool in
                return true
            })
        case FDPlayer.PositionFilterType.QB:
            temp = temp.filter({ (p) -> Bool in
                if(p.position == "QB"){
                    return true
                }else{
                    return false
                }
            })
        case FDPlayer.PositionFilterType.RB:
            temp = temp.filter({ (p) -> Bool in
                if(p.position == "RB"){
                    return true
                }else{
                    return false
                }
            })
        case FDPlayer.PositionFilterType.WR:
            temp = temp.filter({ (p) -> Bool in
                if(p.position == "WR"){
                    return true
                }else{
                    return false
                }
            })
        case FDPlayer.PositionFilterType.TE:
            temp = temp.filter({ (p) -> Bool in
                if(p.position == "TE"){
                    return true
                }else{
                    return false
                }
            })
        case FDPlayer.PositionFilterType.K:
            temp = temp.filter({ (p) -> Bool in
                if(p.position == "K"){
                    return true
                }else{
                    return false
                }
            })
        }
        playerListView.tableView.reloadData()
        playerListView.updateButtonText(sortType, filterType: filterType)
    }

}








