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
    /// The tableView will display the most relavent information to the user on the home page.
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "HeadCoach"
        self.edgesForExtendedLayout = .None
        self.setupHeaderBar()
        self.addNotificationButton()
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
        tableView.backgroundColor = UIColor(white: 0.4, alpha: 1.0)
        tableView.backgroundColor = UIColor.footballColor(0.6)

        tableView.snp_makeConstraints(closure: { make in
            make.top.equalTo(headerBar.snp_bottom)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        })
    }

    // -------------------------------------------------------------------------------------
    // UITableView
    // -------------------------------------------------------------------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")
            as! HCLandingPageDetailCellTableViewCell
        cell.details.text = "Sampe Text!"

        let tap = UITapGestureRecognizer(target: self, action: #selector(HCLandingViewController.openLiveGameView))
        cell.addGestureRecognizer(tap)

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
            
            let name = ["Profile", "League", "Players"][i]
            btn.setTitle(name, forState: .Normal)
            btn.backgroundColor = UIColor.footballColor(1.0 - 0.2 * CGFloat(i % 2))

            switch (i) {
            case 0:
                btn.addTarget(self, action: #selector(HCLandingViewController.openUserDetailView),
                              forControlEvents: .TouchUpInside)
                break
            case 1:
                btn.addTarget(self, action: #selector(HCLandingViewController.openLeagueView),
                              forControlEvents: .TouchUpInside)
                break
            case 2:
                btn.addTarget(self, action: #selector(HCLandingViewController.openPlayersView),
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
        vc.user = HCHeadCoachDataProvider.sharedInstance.user!.name
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCLeagueViewController
    /// This view will be pushed on the current navigation controller.
    func openPlayersView() {
        let vc = HCPlayerDetailViewController()
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
