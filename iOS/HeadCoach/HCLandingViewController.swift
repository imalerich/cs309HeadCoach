//
//  HCLandingViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit

class HCLandingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    /// The headerBar will contain quick links to the primary components of the Application.
    let headerBar = UIView()
    /// Container for the info bar, this will display either the current week information
    /// or any errors that currently occured.
    let infoBar = UIView()
    /// Info text
    let info = UILabel()
    /// The tableView will display the most relavent information to the user on the home page.
    let tableView = UITableView()
    /// We will use a blurred background behind our table view
    let bg = UIImageView()
    /// List of all the users current games.
    /// This will serve as the data to our tableView.
    var games = [HCGameResult]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the blurred background
        bg.image = UIImage(named: "blurred_background")
        bg.contentMode = .ScaleAspectFill
        bg.alpha = 0.4

        view.addSubview(bg)
        bg.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }
 
        self.title = "HeadCoach"
        self.edgesForExtendedLayout = .None
        self.setupHeaderBar()
        self.addNotificationButton()
        self.view.backgroundColor = UIColor.footballColor(0.2)
        self.navigationItem.setHidesBackButton(true, animated: false)

        // add the tableView underneath the header bar
        view.addSubview(self.tableView)
        tableView.registerClass(HCLandingPageDetailCellTableViewCell.self,
                                forCellReuseIdentifier: "BasicCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0)

        tableView.snp_makeConstraints(closure: { make in
            make.top.equalTo(infoBar.snp_bottom)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        })

        reloadTableSource()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.reloadTableSource),
                                                         name: HCHeadCoachDataProvider.LeagueDidUpdate, object: nil)
    }

    // -------------------------------------------------------------------------------------
    // UITableView
    // -------------------------------------------------------------------------------------

    /// Pulls the users schedule from the HeadCoach service.
    /// This method will then reload the table view to
    /// display all the games the user is involved in.
    func reloadTableSource() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        if let league = dp.league, user = dp.user {
            dp.getScheduleForUser(league, user: user, completion: { (err, games) in
                self.games = games
                self.tableView.reloadData()

                if self.games.count == 0 {
                    self.info.text = "No Games Found."
                } else {
                    self.info.text = "Week \(league.week_number)/17"
                }
            })
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")
            as! HCLandingPageDetailCellTableViewCell

        let tap = UITapGestureRecognizer(target: self, action: #selector(HCLandingViewController.openLiveGameView))
        cell.addGestureRecognizer(tap)
        cell.setGame(games[indexPath.row])

        return cell
    }

    // -------------------------------------------------------------------------------------
    // Utilities
    // -------------------------------------------------------------------------------------

    /// Initializes and adds the headerView and its contents.
    func setupHeaderBar() {
        
        // the header background bar
        view.addSubview(headerBar)
        headerBar.snp_makeConstraints(closure: { make in
            make.top.equalTo(view.snp_top)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(85)
        })
        
        // add the buttons to the header view
        for i in 0...2 {
            let btn = UIButton(type: .Custom)
            
            let name = ["Profile", "League", "Chat"][i]
            btn.setTitle(name, forState: .Normal)
            btn.backgroundColor = UIColor.footballColor(1.0 - 0.2 * CGFloat(i % 2))

            switch (i) {
            case 0:
                btn.addTarget(self, action: #selector(self.openUserDetailView),
                              forControlEvents: .TouchUpInside)
                break
            case 1:
                btn.addTarget(self, action: #selector(self.openLeagueView),
                              forControlEvents: .TouchUpInside)
                break
            case 2:
                btn.addTarget(self, action: #selector(self.openChatView),
                              forControlEvents: .TouchUpInside)
                break
            default:
                break
            }

            headerBar.addSubview(btn)
            btn.snp_makeConstraints(closure: { make in
                make.top.equalTo(headerBar.snp_top)
                make.bottom.equalTo(headerBar.snp_bottom)
                make.width.equalTo(headerBar.snp_width).dividedBy(3)
                
                if i == 0 {
                    make.left.equalTo(headerBar.snp_left)
                } else if i == 1 {
                    make.centerX.equalTo(headerBar.snp_centerX)
                } else if i == 2 {
                    make.right.equalTo(headerBar.snp_right)
                }
            })
        }

        infoBar.backgroundColor = UIColor.whiteColor()
        view.addSubview(infoBar)
        infoBar.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.top.equalTo(headerBar.snp_bottom)
            make.height.equalTo(35)
        }

        let PADDING = 8
        info.textColor = UIColor.footballColor(1.0)
        info.font = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
        info.textAlignment = .Center
        info.text = "Loading..."
        infoBar.addSubview(info)
        info.snp_makeConstraints { (make) in
            make.left.equalTo(infoBar.snp_left).offset(PADDING)
            make.right.equalTo(infoBar.snp_right).offset(-PADDING)
            make.top.equalTo(infoBar.snp_top)
            make.bottom.equalTo(infoBar.snp_bottom)
        }

        let bottom = UIView()
        bottom.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        infoBar.addSubview(bottom)
        bottom.snp_makeConstraints { (make) in
            make.left.equalTo(infoBar.snp_left)
            make.right.equalTo(infoBar.snp_right)
            make.bottom.equalTo(infoBar.snp_bottom)
            make.height.equalTo(1)
        }
    }
    
    /// Add the notification button to the navigation bar.
    func addNotificationButton() {
        let btn = UIBarButtonItem(title: "Settings", style: .Plain, target: nil, action: nil)
        btn.action = #selector(HCLandingViewController.openSettingsView)
        btn.target = self

        navigationItem.rightBarButtonItem = btn
    }

    // -------------------------------------------------------------------------------------
    // Open view utilities for event response.
    // -------------------------------------------------------------------------------------

    /// Opens the HCSettingsViewController
    /// This view will be pushed on the current navigation controller.
    func openSettingsView() {
        let vc = HCSettingsViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }

    /// Opens the HCUserDetailViewController
    /// This view will be pushed on the current navigation controller.
    func openUserDetailView() {
        let vc = HCUserDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCChatSelectViewController
    /// This view will be pushed on the current navigation controller.
    func openChatView() {
        let vc = HCChatSelectViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCDraftingViewController
    /// This view will be pushed on the current navigation controller.
    func openLeagueView() {
        let vc = HCLeagueViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCLiveGameViewController
    /// This view will be pushed on the current navigation controller.
    func openLiveGameView() {
        let vc = HCLiveGameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
