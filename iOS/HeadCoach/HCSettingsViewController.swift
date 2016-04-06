//
//  HCSettingsViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/5/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

// ------------------------------
// MARK: HCButtonCell
// ------------------------------

class HCButtonCell: UITableViewCell {
    /// The meat and pototoes of this custom cell.
    let btn = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // construct the view
        let s = CGFloat(0.8)
        btn.setTitleColor(UIColor.footballColor(s), forState: .Normal)
        btn.layer.borderColor = UIColor.footballColor(s).CGColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 6
        btn.backgroundColor = UIColor.whiteColor()
        btn.clipsToBounds = true
        btn.addTouchEvents()

        // and layout the view
        addSubview(btn)
        let offset = 8
        btn.snp_makeConstraints { (make) in
            make.leading.equalTo(self).offset(offset)
            make.trailing.equalTo(self).offset(-offset)
            make.top.equalTo(self).offset(offset)
            make.bottom.equalTo(self).offset(-offset)
        }
    }

    // this shit is required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ------------------------------
// MARK: HCLeagueSelectionCell
// ------------------------------

class HCLeagueSelectionCell: UITableViewCell {
    /// Displays an active label at the right of the cell,
    /// this view is hidden by default, but should be set
    /// as visible for leagues that are currently active.
    let active = UILabel()

    /// Whether or not this cell is currently animating.
    var animating = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // setup the active label
        let s = CGFloat(0.8)
        active.text = "Active"
        active.textAlignment = .Center
        active.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
        active.textColor = UIColor.whiteColor()
        active.backgroundColor = UIColor.footballColor(s)
        active.layer.cornerRadius = 6
        active.clipsToBounds = true
        active.hidden = true

        // and layout the view
        addSubview(active)
        let offset = 8
        active.snp_makeConstraints { (make) in
            make.width.equalTo(80)
            make.trailing.equalTo(self).offset(-offset)
            make.top.equalTo(self).offset(offset)
            make.bottom.equalTo(self).offset(-offset)
        }
    }

    /// Performs a quick animation to show
    /// the 'active' label.
    internal func showActive() {
        animating = true
        active.hidden = false
        active.transform = CGAffineTransformMakeScale(0.95, 0.95)

        UIView.animateWithDuration(0.3, animations: {
            self.active.transform = CGAffineTransformIdentity
        }) { (success) in
            self.animating = false
        }
    }

    /// Performs a quick animation to hide
    /// the 'active' label.
    internal func hideActive() {
        animating = true
        active.transform = CGAffineTransformIdentity

        UIView.animateWithDuration(0.3, animations: {
            self.active.transform = CGAffineTransformMakeScale(0.95, 0.95)
        }) { (success) in
            self.animating = false
            self.active.hidden = true
        }
    }

    // this shit is required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ------------------------------
// MARK: HCSettingsViewController
// ------------------------------

class HCSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /// The table view that will display ann the content for our page.
    let tableView = UITableView()

    /// Array of leagues the user is currently a member of,
    /// the user will be able to join new leagues and 
    /// swap their active league from this view controller
    var usersLeagues = [HCLeague]()

    /// This will be set when a change occurs to the active league,
    /// the 'active' animation will be performed, and then this property
    /// will be set to nil until the next change occurs.
    var newLeague: HCLeague?

    /// The settings view is presented modally, calling this method will
    /// dismiss the modal view.
    internal func dismiss() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = UIColor.whiteColor()

        // this button will dismiss this view when it is presented modally
        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(HCSettingsViewController.dismiss))
        navigationItem.leftBarButtonItem = done

        // setup our table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false

        // table view cell registration
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.registerClass(HCLeagueSelectionCell.self, forCellReuseIdentifier: "LeagueCell")
        tableView.registerClass(HCButtonCell.self, forCellReuseIdentifier: "ButtonCell")

        // setup the constraints for our table view
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        // load the users current leagues, then reload the table view
        // when they are ready
        HCHeadCoachDataProvider.sharedInstance.getAllLeaguesForUser(
            HCHeadCoachDataProvider.sharedInstance.user!) { (err, leagues) in
                if !err {
                    self.usersLeagues = leagues
                    self.tableView.reloadData()
                }
            }
    }

    // ----------------------------------------
    // MARK: UITableView DataSource/Delegate
    // ----------------------------------------

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3

        case 1:
            return 2 + usersLeagues.count

        default:
            return 0
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var id = "Cell"

        if indexPath.section == 1 && indexPath.row != 0 &&
            indexPath.row != 1 + usersLeagues.count {
            id = "LeagueCell"
        }

        if (indexPath.section == 0 && (indexPath.row == 2)) ||
            (indexPath.section == 1 && (indexPath.row == 1 + usersLeagues.count)) {
            id = "ButtonCell"
        }

        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        cell.textLabel?.textColor = UIColor.footballColor(0.8)
        cell.selectionStyle = .None

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.font = UIFont.systemFontOfSize(18)
                cell.backgroundColor = UIColor.footballColor(1.0)
                cell.textLabel!.textColor = UIColor.whiteColor()
                cell.textLabel!.text = "Current User"
                break

            case 1:
                if let user = HCHeadCoachDataProvider.sharedInstance.user {
                    cell.textLabel!.text = user.name
                } else {
                    cell.textLabel!.text = "Please Login"
                }

                break

            case 2:
                let btnCell = cell as! HCButtonCell
                if let _ = HCHeadCoachDataProvider.sharedInstance.user {
                    btnCell.btn.setTitle("Logout", forState: .Normal)
                } else {
                    btnCell.btn.setTitle("Login", forState: .Normal)
                }

                btnCell.btn.addTarget(self,
                                      action: #selector(HCSettingsViewController.logoutUser),
                                      forControlEvents: .TouchUpInside)
                break

            default:
                break
            }

        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.font = UIFont.systemFontOfSize(18)
                cell.backgroundColor = UIColor.footballColor(1.0)
                cell.textLabel!.textColor = UIColor.whiteColor()
                cell.textLabel!.text = "My Leagues"
                break

            case 1 + usersLeagues.count:
                let btnCell = cell as! HCButtonCell
                btnCell.btn.setTitle("Join League", forState: .Normal)
                break

            default:
                let leagueCell = cell as! HCLeagueSelectionCell
                let index = indexPath.row - 1
                let name = usersLeagues[index].name
                leagueCell.textLabel!.text = name

                if newLeague != nil && newLeague?.name == name {
                    leagueCell.showActive()
                    newLeague = nil
                }

                if let league = HCHeadCoachDataProvider.sharedInstance.league {
                    if !leagueCell.animating {
                        leagueCell.active.hidden = !(name == league.name)
                    }
                } else {
                    if !leagueCell.animating {
                        leagueCell.active.hidden = true
                    }
                }

                break
            }

        default:
            break
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section == 1 && indexPath.row > 0
                && indexPath.row != usersLeagues.count + 1 {

            // set a new active league then update the UI
            let index = indexPath.row - 1
            HCHeadCoachDataProvider.sharedInstance.league = usersLeagues[index]
            newLeague = HCHeadCoachDataProvider.sharedInstance.league

            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
        }
    }

    internal func logoutUser() {
        HCHeadCoachDataProvider.sharedInstance.logoutUser()
        self.tableView.reloadRowsAtIndexPaths(
            [NSIndexPath(forRow: 1, inSection: 0), NSIndexPath(forRow: 2, inSection: 0)],
                                              withRowAnimation: .Automatic)
    }
}
