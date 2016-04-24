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
    
    ///Game to display data for
    var game: HCGameResult?
    
    ///Header view
    var header: LiveGameHeaderView?
    
    ///TableView containing players on both teams, sorted by points in this game
    let tableView = UITableView()
    
    ///white background to cover tableView while loading
    let loadingBg = UIView()
    
    ///loading view
    let loading = HCLoadingView.init(info: "Loading")
    
    ///array of pair objects representing scores for all players involved in this game
    /// in the form (playerID, score)
    var pScores = [(Int, UInt32)]()
    
    ///Arrays for all players involved in game
    var HCPlayerList: [HCPlayer]?
    var FDPlayerList: [FDPlayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        // change title of window
        self.title = "Week \(game!.week)"
        
        // add chat button
        let chatButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(self.chatMethod))
        navigationItem.rightBarButtonItem = chatButton
        
        setUpSubViews()
        
        pScores.removeAll()
        HCPlayerList = [HCPlayer]()
        FDPlayerList = [FDPlayer]()
        
        //request HCPlayer data for both users
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
    
    ///Called on result of FDPlayer request
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
    
    ///Returns index of equivalent FDPlayer object in FDPlayerList array
    func findFDIndex(playerId: Int) -> Int{
        for i in 0...FDPlayerList!.count{
            if FDPlayerList![i].id == playerId{
                return i
            }
        }
        return -1
    }
    
    ///Searches pScores and returns score pair in form (playerID, score) for given playerId
    func findScore(playerId: Int) -> (index: Int, score: UInt32){
        for i in 0...pScores.count-1{
            if pScores[i].0 == playerId{
                return (i, pScores[i].1)
            }
        }
        return (-1, 0)
    }
    
    ///Set up all subviews
    func setUpSubViews(){
        setUpGameHeader()
        setUpTableView()
        setUpLoadingBg()
        setUpLoading()
    }
    
    ///Set up loading view
    func setUpLoading(){
        self.view.addSubview(loading)
        loading.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    ///Set up loading background, covers only tableView
    func setUpLoadingBg(){
        loadingBg.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(loadingBg)
        loadingBg.snp_makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(header!.snp_bottom)
        }
    }
    
    ///Set up player table view
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(header!.snp_bottom)
        }
        self.tableView.registerClass(LiveGameTableViewCell.self, forCellReuseIdentifier: "LiveCell")
    }
    
    ///Set up user info header
    func setUpGameHeader(){
        header = LiveGameHeaderView(game: self.game!)
        view.addSubview(header!)
        header!.snp_makeConstraints { (make) in
            make.height.equalTo(125)
            make.width.equalTo(self.view)
            make.top.equalTo(self.view)
        }
        
        let userTap = UITapGestureRecognizer(target: self, action: #selector(HCLiveGameViewController.userTapped(_:)))
        header?.addGestureRecognizer(userTap)
    }
    
    ///Called on tap of header to open relevant user detail
    func userTapped(sender: UITapGestureRecognizer){
        let tapLocation = sender.locationInView(self.header!.u1Image)
        if(header!.u1Image.pointInside(tapLocation, withEvent: nil)){
            openUserDetailView(game!.users.0)
        }
        else{
            let tapLocation = sender.locationInView(self.header!.u2Image)
            if(header!.u2Image.pointInside(tapLocation, withEvent: nil)){
                openUserDetailView(game!.users.1)
            }
        }
    }
    
    ///Open user detail for user
    func openUserDetailView(forUser: HCUser) {
        let vc = HCUserDetailViewController()
        vc.user = forUser
        navigationController?.pushViewController(vc, animated: true)
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HCLiveGameViewController.cellTapped(_:)))
        cell?.addGestureRecognizer(tap)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = HCPlayerMoreDetailController(forHCPlayer: HCPlayerList![indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///tableView cell tap
    func cellTapped(sender: UITapGestureRecognizer)
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
