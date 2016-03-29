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

        // add the tableView underneath the header bar
        view.addSubview(self.tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp_makeConstraints(closure: { make in
            make.top.equalTo(headerBar.snp_bottom)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        })
    }
    
    /* -------------------------------------------------------------------------------------------------------
        UITableView
    ------------------------------------------------------------------------------------------------------- */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        cell.textLabel?.text = "SampleText"

        return cell
    }
    
    /* -------------------------------------------------------------------------------------------------------
        Utilities
    ------------------------------------------------------------------------------------------------------- */
    
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
            
            let name = ["Team", "League", "Drafts"][i]
            btn.setTitle(name, forState: .Normal)
            let s = 1.0 - 0.2 * CGFloat(i % 2)
            btn.backgroundColor = UIColor(red: 0, green: s * 92/222.0, blue: s * 9/255.0, alpha: 1.0)

            switch (i) {
            case 0:
                btn.addTarget(self, action: #selector(HCLandingViewController.openTeamView),
                              forControlEvents: .TouchUpInside)
                break
            case 1:
                btn.addTarget(self, action: #selector(HCLandingViewController.openLeagueView),
                              forControlEvents: .TouchUpInside)
                break
            case 2:
                btn.addTarget(self, action: #selector(HCLandingViewController.openDraftingView),
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
        let btn = UIBarButtonItem(title: "Profile", style: .Plain, target: nil, action: nil)
        btn.target = self
        btn.action = #selector(HCLandingViewController.openUserView)
        navigationItem.rightBarButtonItem = btn
    }

    /// Opens the HCTeamManagementViewController
    /// This view will be pushed on the current navigation controller.
    func openTeamView() {
        let vc = HCTeamManagementViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCLeagueViewController
    /// This view will be pushed on the current navigation controller.
    func openDraftingView() {
        let vc = HCDraftingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCDraftingViewController
    /// This view will be pushed on the current navigation controller.
    func openLeagueView() {
        let vc = HCLeagueViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// Opens the HCPlayerDetailViewController
    /// This view will be pushed on the current navigation controller.
    func openUserView() {
        let vc = HCUserDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
