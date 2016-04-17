//
//  HCJoinLeagueViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/8/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit
import Alamofire

class HCJoinLeagueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var pageController: HCSetupViewController? = nil

    let Cell = "Cell"

    let info = UILabel()
    let join = UIButton()
    let createInfo = UILabel()
    let createName = UITextField()
    let create = UIButton()
    let tableView = UITableView()
    var imagePicker = UIImagePickerController()
    let upload = UIButton()

    var selected = Set<NSIndexPath>()
    var leagues = [HCLeague]()

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        layoutViews()
        loadAvailableLeagues()
    }

    internal func createViews() {
        info.numberOfLines = 0
        info.text = "Select the leagues you would like to join,"
        info.textAlignment = .Center
        info.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        info.adjustsFontSizeToFitWidth = true
        info.textColor = UIColor.whiteColor()

        join.setTitle("Join Leagues", forState: .Normal)
        join.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        join.addTarget(self, action: #selector(self.joinLeague), forControlEvents: UIControlEvents.TouchUpInside)
        join.backgroundColor = UIColor.footballColor(1.3)
        join.layer.cornerRadius = 25
        join.addTouchEvents()

        createInfo.numberOfLines = 0
        createInfo.text = "or create a new league."
        createInfo.textAlignment = .Center
        createInfo.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        createInfo.adjustsFontSizeToFitWidth = true
        createInfo.textColor = UIColor.whiteColor()

        createName.layer.cornerRadius = 8
        createName.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).CGColor
        createName.layer.borderWidth = 1
        createName.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        createName.textColor = UIColor.whiteColor()
        createName.textAlignment = .Center

        create.setTitle("Create League", forState: .Normal)
        create.setTitleColor(UIColor.footballColor(1.3), forState: .Normal)
        create.titleLabel!.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        create.addTarget(self, action: #selector(self.createLeague), forControlEvents: UIControlEvents.TouchUpInside)
        create.layer.cornerRadius = 25
        create.backgroundColor = UIColor.whiteColor()
        create.addTouchEvents()
        
        
        
        tableView.layer.cornerRadius = 8
        tableView.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).CGColor
        tableView.layer.borderWidth = 1
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: Cell)
        tableView.delegate = self
        tableView.dataSource = self
    }

    internal func layoutViews() {
        view.addSubview(info)
        info.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left).offset(20)
            make.right.equalTo(view.snp_right).offset(-20)
            make.top.equalTo(view.snp_top).offset(20)
            make.height.equalTo(40)
        }

        view.addSubview(join)
        join.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-32)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        view.addSubview(create)
        create.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.bottom.equalTo(join.snp_top).offset(-16)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        view.addSubview(createName)
        createName.snp_makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(create.snp_top).offset(-16)
            make.left.equalTo(view.snp_left).offset(20)
            make.right.equalTo(view.snp_right).offset(-20)
        }

        view.addSubview(createInfo)
        createInfo.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.bottom.equalTo(createName.snp_top).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }

        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left).offset(20)
            make.right.equalTo(view.snp_right).offset(-20)
            make.top.equalTo(info.snp_bottom).offset(10)
            make.bottom.equalTo(createInfo.snp_top).offset(-8)
        }
        
        view.addSubview(upload)
    }

    internal func loadAvailableLeagues() {
        HCHeadCoachDataProvider.sharedInstance.getAllLeagues { (err, leagues) in
            self.leagues = leagues
            self.tableView.reloadData()
        }
    }

    internal func createLeague() {
        // do some basic error checking for a valid league name
        if let name = createName.text {
            if name.characters.count == 0 {
                displayError("Please enter a valid name.")
            }
        } else {
            displayError("Please enter a valid name.")
        }

        let loading = HCLoadingView(info: "Creating your League.\n(this may take a while)")
        loading.present(self.view, animated: true)
        let name = createName.text!.stringByReplacingOccurrencesOfString(" ", withString: "_")
        HCHeadCoachDataProvider.sharedInstance.registerLeague(name) { (err) in
            loading.dismiss(true)
            self.createName.text = ""
            if err {
                self.displayError("A league already exists with that name!")
            } else {
                self.loadAvailableLeagues()
            }
        }
    }

    internal func displayError(string: String) {
        let alert = UIAlertController(title: "Error",
                                      message: string,
                                      preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    internal func joinLeague() {
        let user = HCHeadCoachDataProvider.sharedInstance.user
        if user == nil {
            self.pageController?.dismissViewControllerAnimated(true, completion: nil)
        }

        if selected.count == 0 {
            displayError("Please select at least 1 league.")
            return
        }

        // select the first league
        HCHeadCoachDataProvider.sharedInstance.league = leagues[0]

        for i in 0...(selected.count-1) {
            HCHeadCoachDataProvider.sharedInstance.addUserToLeague(user!, league: leagues[i], completion: { (err) in })
        }

        self.pageController?.dismissViewControllerAnimated(true, completion: nil)
    }

    // mark - UITableViewDataSource/Delegate

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let league = leagues[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell, forIndexPath: indexPath)
        cell.textLabel!.text = league.name
        cell.tintColor = UIColor.footballColor(2.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None

        if selected.contains(indexPath) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selected.contains(indexPath) {
            selected.remove(indexPath)
        } else {
            selected.insert(indexPath)
        }

        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
 
}
