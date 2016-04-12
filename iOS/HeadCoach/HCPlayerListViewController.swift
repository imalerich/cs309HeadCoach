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
    var undraftedPlayers : [(HCPlayer)] = []
    var displayedPlayers : [(HCPlayer)] = []
    // TODO - rely on position selected in Position Menu
    var selectedPos = Position.All
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO - MAKE THIS SHIT WORK
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPlayers.count
    }
}
