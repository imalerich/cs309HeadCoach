//
//  HCDraftingViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit

class HCDraftingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var numPlayers = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change title of window
        self.title = "Drafting"
        
        // initialize tableView
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        // TODO - register custom cell
        
    }
    
    // one section used, containing all rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numPlayers + 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0 || indexPath.row == 1){
            return 60
        }
        return 100
    }
    
    
}
