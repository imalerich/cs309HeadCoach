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
    
    var game: HCGameResult?
    
    let header = UIView()
    let tableView = UITableView()
    let loadingBg = UIView()
    let loading = HCLoadingView.init(info: "Loading")
    var pScores = [(Int, UInt32)]()
    
    var HCPlayerList: [HCPlayer]?
    var FDPlayerList: [FDPlayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        // change title of window
        self.title = "Game"
        
        // add chat button
        let chatButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(self.chatMethod))
        navigationItem.rightBarButtonItem = chatButton
        
        setUpSubViews()
        
        pScores.removeAll()
        HCPlayerList = [HCPlayer]()
        FDPlayerList = [FDPlayer]()
        HCHeadCoachDataProvider.sharedInstance.getAllPlayersForUserFromLeague(HCHeadCoachDataProvider.sharedInstance.league!, user: game!.users.0, completion: HCLiveGameViewController.onHDPlayerListResult(self))
        HCHeadCoachDataProvider.sharedInstance.getAllPlayersForUserFromLeague(HCHeadCoachDataProvider.sharedInstance.league!, user: game!.users.1, completion: HCLiveGameViewController.onHDPlayerListResult(self))
    }
    
    func onHDPlayerListResult(empty: Bool, players: [HCPlayer]){
        if !empty {
            var gameScore = UInt32(players[0].user_id == game!.users.0.id ? game!.scores.0 : game!.scores.1)
            for player in players{
                //add player score and sort if active
                if !player.isOnBench {
                    let points = arc4random_uniform(gameScore)
                    gameScore -= points
                    pScores.append((player.fantasy_id, points))
                    
                    //add player and request equivalent FDplayer
                    HCPlayerList?.append(player)
                    HCFantasyDataProvider.sharedInstance.getFDPlayerFromHCPlayer(player, completion: HCLiveGameViewController.onFDPlayerResult(self))
                    pScores.sortInPlace({ (s1, s2) -> Bool in
                        s1.1 > s2.1
                    })
                }
            }
        }
    }
    
    // method for performing live player chat actions
    func chatMethod(){
        print(HCRandomInsultGenerator.sharedInstance.generateInsult())
    }
    
    func onFDPlayerResult(player: FDPlayer){
        FDPlayerList?.append(player)
        FDPlayerList?.sortInPlace({ (p1, p2) -> Bool in
            findScore(p1.id).index < findScore(p2.id).index
        })
        tableView.reloadData()
        if(FDPlayerList?.count == HCPlayerList?.count){
            HCPlayerList?.sortInPlace({ (p1, p2) -> Bool in
                findFDIndex(p1.fantasy_id) < findFDIndex(p2.fantasy_id)
            })
            UIView.animateWithDuration(0.5, animations: { 
                self.loadingBg.alpha = 0.0
                }, completion: { (b) in
                    if b {
                        self.loadingBg.hidden = true
                    }
            })
            loading.dismiss(true)
        }
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
        var cell = tableView.dequeueReusableCellWithIdentifier("LiveCell", forIndexPath: indexPath) as? LiveGameTableViewCell
        if (cell == nil)
        {
            cell = LiveGameTableViewCell(style: UITableViewCellStyle.Default,
                                   reuseIdentifier:"LiveCell")
        }
        let player = FDPlayerList![indexPath.row]
        let winningTeam = HCPlayerList?[indexPath.row].user_id == (game?.scores.0 > game?.scores.1 ? game?.users.0.id : game?.users.1.id)
        cell?.setPlayer(player, hcplayer: HCPlayerList![indexPath.row], pts: findScore(player.id).score, winner: winningTeam)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HCLiveGameViewController.tapped(_:)))
        cell?.addGestureRecognizer(tap)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = HCPlayerMoreDetailController(forHCPlayer: HCPlayerList![indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapped(sender: UITapGestureRecognizer)
    {
        //using sender, we can get the point in respect to the table view
        let tapLocation = sender.locationInView(self.tableView)
        
        //using the tapLocation, we retrieve the corresponding indexPath
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        let vc = HCPlayerMoreDetailController(forHCPlayer: HCPlayerList![indexPath!.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (FDPlayerList?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Player List"
    }
    
    func findFDIndex(playerId: Int) -> Int{
        for i in 0...FDPlayerList!.count{
            if FDPlayerList![i].id == playerId{
                return i
            }
        }
        return -1
    }
    
    func findScore(playerId: Int) -> (index: Int, score: UInt32){
        for i in 0...pScores.count-1{
            if pScores[i].0 == playerId{
                return (i, pScores[i].1)
            }
        }
        return (-1, 0)
    }
    
    func setUpSubViews(){
        addGameHeader()
        setUpTableView()
        setUpLoadingBg()
        setUpLoading()
    }
    
    func setUpLoading(){
        self.view.addSubview(loading)
        loading.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setUpLoadingBg(){
        loadingBg.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(loadingBg)
        loadingBg.snp_makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(header.snp_bottom)
        }
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(header.snp_bottom)
        }
        self.tableView.registerClass(LiveGameTableViewCell.self, forCellReuseIdentifier: "LiveCell")
    }
    
    func addGameHeader(){
        self.view.addSubview(header)
        header.backgroundColor = UIColor.whiteColor()
        header.snp_makeConstraints { (make) in
            make.height.equalTo(60)
            make.width.equalTo(self.view)
            make.top.equalTo(self.view)
        }
        let u1bg = UIView()
        let u2bg = UIView()
        let u1Name = UILabel()
        let u2Name = UILabel()
        let u1Score = UILabel()
        let u2Score = UILabel()
        let divider = UIView()
        /// A little star icon that will show up next to the winners score.
        let win = UIImageView()
        
        self.view.addSubview(u1bg)
        self.view.addSubview(u2bg)
        self.view.addSubview(u1Name)
        self.view.addSubview(u2Name)
        self.view.addSubview(u1Score)
        self.view.addSubview(u2Score)
        self.view.addSubview(win)
        self.view.addSubview(divider)
        
        u1bg.snp_makeConstraints { (make) in
            make.left.equalTo(header)
            make.right.equalTo(divider.snp_left)
            make.top.equalTo(header)
            make.bottom.equalTo(header)
        }
        
        u2bg.snp_makeConstraints { (make) in
            make.left.equalTo(divider.snp_right)
            make.right.equalTo(header)
            make.top.equalTo(header)
            make.bottom.equalTo(header)
        }
        
        divider.backgroundColor = UIColor.whiteColor()
        divider.snp_makeConstraints { (make) in
            make.center.equalTo(self.header)
            make.width.equalTo(1)
            make.height.equalTo(self.header).multipliedBy(0.8)
        }
        
        win.snp_makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalTo(header)
            if game?.scores.0 > game?.scores.1{
                make.right.equalTo(divider.snp_left).offset(-3)
            }
            else{
                make.left.equalTo(divider.snp_right).offset(3)
            }
        }
        
        u1Name.text = game!.users.0.name
        u1Name.font = UIFont.systemFontOfSize(20)
        u1Name.textColor = game?.scores.0 > game?.scores.1 ? UIColor.whiteColor() : UIColor.footballColor(1)
        u1bg.backgroundColor = game?.scores.0 > game?.scores.1 ? UIColor.footballColor(1) : UIColor.whiteColor()
        u1Name.sizeToFit()
        u1Name.snp_makeConstraints { (make) in
            make.centerY.equalTo(header)
            if game?.scores.0 > game?.scores.1{
                make.right.equalTo(win.snp_left).offset(-5)
            }
            else{
                make.right.equalTo(divider.snp_left).offset(-5)
            }
        }
        
        u2Name.text = game!.users.1.name
        u2Name.font = UIFont.systemFontOfSize(20)
        u2Name.textColor = game?.scores.1 > game?.scores.0 ? UIColor.whiteColor() : UIColor.footballColor(1)
        u2bg.backgroundColor = game?.scores.1 > game?.scores.0 ? UIColor.footballColor(1) : UIColor.whiteColor()
        u2Name.sizeToFit()
        u2Name.snp_makeConstraints { (make) in
            make.centerY.equalTo(header)
            if game?.scores.1 > game?.scores.0{
                make.left.equalTo(win.snp_right).offset(5)
            }
            else{
                make.left.equalTo(divider.snp_right).offset(5)
            }
        }
        
        u1Score.text = String(game!.scores.0)
        u1Score.font = UIFont.systemFontOfSize(20)
        u1Score.textColor = game?.scores.0 > game?.scores.1 ? UIColor.whiteColor() : UIColor.footballColor(1)
        u1Score.sizeToFit()
        u1Score.snp_makeConstraints { (make) in
            make.left.equalTo(header).offset(15)
            make.centerY.equalTo(header)
        }
        
        u2Score.text = String(game!.scores.1)
        u2Score.font = UIFont.systemFontOfSize(20)
        u2Score.textColor = game?.scores.1 > game?.scores.0 ? UIColor.whiteColor() : UIColor.footballColor(1)
        u2Score.snp_makeConstraints { (make) in
            make.right.equalTo(header).offset(-15)
            make.centerY.equalTo(header)
        }
        
        win.image = UIImage(named: "win")
        win.contentMode = .ScaleAspectFill
        
    }
}
