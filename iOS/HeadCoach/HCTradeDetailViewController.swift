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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        detail = TradeDetailView(frame: view.bounds)
        view.addSubview(detail)
        detail.addCustomView()
    }
}