//
//  HCTradeInfoViewController.swift
//  HeadCoach
//
//  Created by Davor Civsa on 3/30/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import RealmSwift
import ImageLoader

class HCTradeDetailViewController: UIViewController, UITextViewDelegate{
    
    let progress = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    var detail: TradeDetailView!
    var user1: HCUser!
    var user2: HCUser!
    var player1: FDPlayer!
    var player2: FDPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        detail = TradeDetailView(frame: view.bounds)
        view.addSubview(detail)
        detail.addCustomView()
        detail.setPlayer1(player1)
        requestPlayerStats(player1.id)
    }
    
    func requestPlayerStats(playerID: Int){
        HCFantasyDataProvider.sharedInstance.getPlayerStatsForPlayerID(playerID, handler: TradeDetailView.setStats(detail))
    }
}