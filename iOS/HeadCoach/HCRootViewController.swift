//
//  RootViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/16/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit

class HCRootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // make super dope app here
        view.addSubview(self.tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp_makeConstraints(closure: { make in
            make.edges.equalTo(self.view)
        })

        HCHeadCoachDataProvider.sharedInstance.getAllUsers()

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")
        cell?.textLabel?.text = ["Live Game", "Landing View", "Team Management", "Drafting View", "Player Detail", "User Detail"][indexPath.row];

        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var vc: UIViewController?
        switch (indexPath.row) {
        case 0:
            vc = HCLiveGameViewController()
            break;
        case 1:
            vc = HCLandingViewController()
            break;
        case 2:
            vc = HCTeamManagementViewController()
            break;
        case 3:
            vc = HCDraftingViewController()
            break;
        case 4:
            vc = HCPlayerDetailViewController()
            break;
        case 5:
            vc = HCUserDetailViewController()
            break;
        default:
            break;
        }

        self.navigationController?.pushViewController(vc!, animated: true)
    }

}