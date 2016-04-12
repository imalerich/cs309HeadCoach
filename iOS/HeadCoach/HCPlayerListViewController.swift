//
//  HCPlayerListView.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/11/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift


class HCPlayerListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let menu = HCPositionMenu()
    var undraftedPlayers : [(HCPlayer)] = []
    var displayedPlayers : [(HCPlayer)] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // add views
        self.view.addSubview(menu)
        self.view.addSubview(tableView)
        
        self.title = "Drafting"
        
        let dp = HCHeadCoachDataProvider.sharedInstance
        
        if(undraftedPlayers.count == 0){
            dp.getUndraftedPlayersInLeague(dp.league!) { (error, players) in
                self.undraftedPlayers = players
                self.tableView.reloadData()
            }
        }
        
        if(menu.position == Position.All){
            displayedPlayers = undraftedPlayers
        }
        
        // layout views
        menu.snp_makeConstraints { (make) in
            make.left.right.top.width.equalTo(self.view)
            make.bottom.equalTo(self.view).dividedBy(6.0)
            make.height.equalTo(60)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.width.equalTo(self.view)
            make.top.equalTo(menu.snp_bottom)
            make.height.equalTo(self.view).offset(-60)
        }
        
        // register custom class
        self.tableView.registerClass(HCPlayerListCell.classForCoder(), forCellReuseIdentifier: "PlayerListCell")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO - MAKE THIS SHIT WORK
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerListCell", forIndexPath: indexPath) as! HCPlayerListCell
        
        cell.changePlayer(displayedPlayers[indexPath.row])
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPlayers.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
