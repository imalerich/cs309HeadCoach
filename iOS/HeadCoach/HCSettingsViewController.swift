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
// MARK: HCSettingsUpdateCell
// ------------------------------

class HCSettingsUpdateCell: UITableViewCell {
    /// The minimum week we can update a league too.
    let MINIMUM_WEEK = 0

    /// The maximum week we can update a league too.
    let MAXIMUM_WEEK = 17

    /// Button to decrement the current week index.
    let decrement = UIButton()

    /// Button to increment the current week index.
    let increment = UIButton()

    /// UILabel for displaying the 'week' property.
    let weekLabel = UILabel()

    /// Pressing this button will update all leagues in
    /// the HeadCoach service to the week given by this
    /// cells 'week' parameter.
    let update = UIButton()

    /// The current week number to display.
    /// This is not actually the current week for the league,
    /// it is the week we wish to set all leagues to when we hit
    /// the 'update' button.
    var week = 0

    /// Parent view controller. When the update button is pressed
    /// we will need this reference to present a loading screen
    /// over the display.
    var vc: UIViewController?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        // Get a starting week from the data provider if it is available.
        let dp = HCHeadCoachDataProvider.sharedInstance
        if let league = dp.league {
            week = league.week_number
            validateWeek()
        }

        // setup our labels and buttons

        let s = CGFloat(0.8)
        update.setTitleColor(UIColor.footballColor(s), forState: .Normal)
        update.layer.borderColor = UIColor.footballColor(s).CGColor
        update.backgroundColor = UIColor.clearColor()
        update.setTitle("Update", forState: .Normal)
        update.layer.cornerRadius = 6
        update.layer.borderWidth = 1
        update.clipsToBounds = true
        update.addTarget(self, action: #selector(self.updateLeagues), forControlEvents: .TouchUpInside)
        update.addTouchEvents()

        increment.setTitle("+", forState: .Normal)
        increment.titleLabel?.font = UIFont.systemFontOfSize(18, weight: UIFontWeightHeavy)
        increment.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        increment.backgroundColor = UIColor.footballColor(s)
        increment.addTouchEvents()
        increment.addTarget(self, action: #selector(self.incrementWeek), forControlEvents: .TouchUpInside)

        decrement.setTitle("-", forState: .Normal)
        decrement.titleLabel?.font = UIFont.systemFontOfSize(18, weight: UIFontWeightHeavy)
        decrement.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        decrement.backgroundColor = UIColor.footballColor(s)
        decrement.addTouchEvents()
        decrement.addTarget(self, action: #selector(self.decrementWeek), forControlEvents: .TouchUpInside)

        weekLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        weekLabel.textColor = UIColor.footballColor(s)
        weekLabel.textAlignment = .Center
        weekLabel.text = "\(week)"

        // layout the labels and buttons

        // offset parameter for our view layouts
        let OFFSET = 8

        addSubview(decrement)
        decrement.snp_makeConstraints { (make) in
            make.left.bottom.top.equalTo(self)
            make.width.equalTo(self.snp_height)
        }

        addSubview(weekLabel)
        weekLabel.snp_makeConstraints { (make) in
            make.left.equalTo(decrement.snp_right)
            make.bottom.top.equalTo(self)
            make.width.equalTo(self.snp_height)
        }

        addSubview(increment)
        increment.snp_makeConstraints { (make) in
            make.left.equalTo(weekLabel.snp_right)
            make.bottom.top.equalTo(self)
            make.width.equalTo(self.snp_height)
        }

        addSubview(update)
        update.snp_makeConstraints { (make) in
            make.left.equalTo(increment.snp_right).offset(OFFSET)
            make.right.equalTo(self).offset(-OFFSET)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

    @objc private func updateLeagues() {
        // we need the parent view controller to display the loading view
        if vc == nil {
            exit(EXIT_FAILURE)
        }

        let dp = HCHeadCoachDataProvider.sharedInstance
        let loading = HCLoadingView(info: "Updating.\nThis may take a while.")
        loading.present(vc!.view, animated: true)
        dp.updateLeaguesToWeek(week) { (err) in
            loading.dismiss(true)
        }
    }

    /// Increment the 'week' value, validate the week number, and update the label.
    @objc private func incrementWeek() {
        week += 1
        validateWeek()
        weekLabel.text = "\(week)"
    }

    /// Decrement the 'week' value, validate the week number, and update the label.
    @objc private func decrementWeek() {
        week -= 1
        validateWeek()
        weekLabel.text = "\(week)"
    }

    /// Make's sure the 'week' parameter is within the bounds
    /// of the 'MINIMUM_WEEK' and 'MAXIMUM_WEEK'.
    @objc private func validateWeek() {
        week = min(max(week, MINIMUM_WEEK), MAXIMUM_WEEK)
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

    /// Totally not used for anything, not ever, nope, I swear.
    var notActuallyUsedForAnything = 0

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
        tableView.registerClass(HCSettingsUpdateCell.self, forCellReuseIdentifier: "UpdateCell")

        // setup the constraints for our table view
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        NSNotificationCenter.defaultCenter().addObserver(self.tableView, selector: #selector(UITableView.reloadData),
                                                         name: HCHeadCoachDataProvider.UserDidLogin, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.loadLeagues),
                                                         name: HCHeadCoachDataProvider.UserDidLogin, object: nil)

        loadLeagues()
    }

    /// Loads the leagues for the given user, then reloads the table
    /// view once those leagues have been obtained.
    /// @objc is needed to be accessible to selectors.
    @objc private func loadLeagues() {
        // load the users current leagues, then reload the table view
        // when they are ready
        if let user = HCHeadCoachDataProvider.sharedInstance.user {
            HCHeadCoachDataProvider.sharedInstance.getAllLeaguesForUser(user) { (err, leagues) in
                if !err {
                    self.usersLeagues = leagues
                    self.tableView.reloadData()
                } else {
                    self.usersLeagues = [HCLeague]()
                    self.tableView.reloadData()
                }
            }
        }
    }

    // ----------------------------------------
    // MARK: Useless section
    //  This section does not do anything
    // ----------------------------------------

    /// This method does not do anything important.
    func didTapUser() {
        notActuallyUsedForAnything += 1
        if notActuallyUsedForAnything > 4 {
            notActuallyUsedForAnything = 0
            let vc = HCMiniGameViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // ----------------------------------------
    // MARK: UITableView DataSource/Delegate
    // ----------------------------------------

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3

        case 1:
            return 2 + usersLeagues.count

        case 2:
            return 1

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

        if indexPath.section == 2 {
            id = "UpdateCell"
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
                    btnCell.btn.setTitle("Change User", forState: .Normal)
                } else {
                    btnCell.btn.setTitle("Login", forState: .Normal)
                }

                btnCell.btn.addTarget(self,
                                      action: #selector(HCSettingsViewController.changeUser),
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

        case 2:
            if let updateCell = cell as? HCSettingsUpdateCell {
                updateCell.vc = self
            }

            break

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

        // Not sure why this code is here, it TOTALLY does not do anything.
        if indexPath.section == 0 && indexPath.row == 1 {
            didTapUser()
        }
    }

    internal func changeUser() {
        HCHeadCoachDataProvider.sharedInstance.logoutUser()
        self.tableView.reloadRowsAtIndexPaths(
            [NSIndexPath(forRow: 1, inSection: 0), NSIndexPath(forRow: 2, inSection: 0)],
                                              withRowAnimation: .Automatic)

        navigationController!.presentViewController(HCSetupViewController(), animated: true, completion: nil)
    }
}
