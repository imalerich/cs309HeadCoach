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

    var currentPosition = Position.All
    var players = Dictionary<String, Array<HCPlayer>>()

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

        setupPlayersDict()
        updatePlayersList()
    }


    /// Call this whenever you want to update the players data list
    /// for our use case, this will only be once at the creation of this class
    func updatePlayersList() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.getUndraftedPlayersInLeague(dp.league!) { (error, players) in
            self.setupPlayersDict()
            for player in players {
                self.players[HCPositionUtil.positionToString(player.position)]?.append(player)
            }

            self.setCurrentPosition(Position.QuarterBack)
        }
    }

    /// Updates the menu text to describe the new position
    /// pull the undrafted players for that position
    /// then reloads the data for the table view
    func setCurrentPosition(pos: Position) {
        currentPosition = pos
        menu.label.text = "Position: \(HCPositionUtil.positionToName(pos))"

        tableView.reloadData()
    }

    func setupPlayersDict() {
        for pos in HCPositionUtil.getAllPositions() {
            let key = HCPositionUtil.positionToString(pos)
            players[key] = Array<HCPlayer>()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO - MAKE THIS SHIT WORK
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerListCell", forIndexPath: indexPath) as! HCPlayerListCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor() : UIColor(white: 0.9, alpha: 1.0)
        cell.changePlayer(players[HCPositionUtil.positionToString(currentPosition)]![indexPath.row])
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players[HCPositionUtil.positionToString(currentPosition)]!.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dp = HCFantasyDataProvider()
        let player = players[HCPositionUtil.positionToString(currentPosition)]![indexPath.row]

        dp.getFDPlayerFromHCPlayer(player) { (fd_player) in
            let vc = HCPlayerMoreDetailController()
            vc.player = fd_player

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
