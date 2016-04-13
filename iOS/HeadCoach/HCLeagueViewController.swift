//
//  HCLeagueViewController.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/28/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit
import ImageLoader


class HCLeagueViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    /// List of users, this will be our data source for the table view.
    var users = [HCUser]()

    /// The actual table view that will display our data.
    let tableView = UITableView()

    /// Cell reuse identifier for our user cells.
    let CELL_ID = "LeagueCell"

    /// Cell reuse identifier for our header view.
    let HEADER_ID = "LeagueHeaderCell"

    override func viewDidLoad(){
        super.viewDidLoad()

        // Create our table view.
        tableView.registerClass(HCLeagueTableViewCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.registerClass(HCLeagueDetailsHeaderCell.self, forHeaderFooterViewReuseIdentifier: HEADER_ID)
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self

        let background = UIImageView(image: UIImage(named: "blurred_background"))
        background.contentMode = .ScaleAspectFill
        background.alpha = 0.4
        tableView.backgroundColor = UIColor.footballColor(0.2)
        tableView.backgroundView = background

        // Layout the table view.
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        // Update our data in the event that the current active league changes.
        // This will probably never happen, but I have included it just in case.
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.loadUsersFromProvider),
                                                         name: HCHeadCoachDataProvider.LeagueDidUpdate,
                                                         object: nil)
        loadUsersFromProvider()
    }

    /// Asks the data provider for a list of all users from the current league.
    /// When the users are retrieved this will reload the data in the table view.
    @objc private func loadUsersFromProvider() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        if let league = dp.league {
            title = league.name
            
            dp.getAllUsersForLeague(league, completion: { (err, users) in
                self.users = users
                self.tableView.reloadData()
            })
        }
    }

    // ------------------------------------------
    // mark - UITableView
    // ------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID, forIndexPath: indexPath) as! HCLeagueTableViewCell
        cell.setUser(users[indexPath.row])

        return cell
            
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HCLeagueDetailsHeaderCell(reuseIdentifier: HEADER_ID)
        if let league = HCHeadCoachDataProvider.sharedInstance.league {
            view.setLeague(league)
        }

        return view
    }

}



