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
    var undraftedPlayers = [HCPlayer]()
    var displayedPlayers = [HCPlayer]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "Drafting"
        
        // register custom class
        tableView.registerClass(HCPlayerListCell.classForCoder(), forCellReuseIdentifier: "PlayerListCell")
        tableView.delegate = self
        tableView.dataSource = self

        // this fixes the menu being underneath the navigation bar
        // don't ask, its stupid
        edgesForExtendedLayout = .None

        // do not actually use purple here
        menu.backgroundColor = UIColor.footballColor(1.0)

        if menu.position == Position.All {
            displayedPlayers = undraftedPlayers
        }
        
        // layout views
        self.view.addSubview(menu)
        menu.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(60)
        }

        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(menu.snp_bottom)
        }

        updatePlayersList()
    }

    func updatePlayersList() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.getUndraftedPlayersInLeague(dp.league!) { (error, players) in
            self.undraftedPlayers = players
            self.displayedPlayers = self.undraftedPlayers
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO - MAKE THIS SHIT WORK
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerListCell", forIndexPath: indexPath) as! HCPlayerListCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor() : UIColor(white: 0.9, alpha: 1.0)
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
        return 60
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO
        // Here, and only here, make a network request to create an FDPlayer from 
        // the fantasy_id, right now the Fantasy Data provider gets all fd players, 
        // it will need a call to only get one, as our new design does not require all of them
        // as we get all of them from my data provider
        // once this network request is done, you can pass it into davors view to view that player
    }
}
