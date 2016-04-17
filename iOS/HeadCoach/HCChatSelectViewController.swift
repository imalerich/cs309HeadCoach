//
//  HCChatSelectViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/16/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

// MARK: HCChatSelectCell

class HCChatSelectCell: UITableViewCell {

    /// Constant offset parameter for view layout.
    static let OFFSET = 12

    /// Users image cell.
    let img = UIImageView()

    /// User name label.
    let name = UILabel()

    /// Preview text label.
    let preview = UILabel()

    /// Displays the total number of messages in this conversation.
    let count = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // setup our labels
        name.textColor = UIColor.blackColor()
        name.font = UIFont.systemFontOfSize(20)
        preview.textColor = UIColor(white: 0.2, alpha: 1.0)
        preview.font = UIFont.systemFontOfSize(13, weight: UIFontWeightLight)
        count.textAlignment = .Right
        count.textColor = UIColor(white: 0.4, alpha: 1.0)

        // add and layout the subviews
        addSubview(img)
        img.snp_makeConstraints { (make) in
            make.left.top.equalTo(self).offset(HCChatSelectCell.OFFSET)
            make.bottom.equalTo(self).offset(-HCChatSelectCell.OFFSET)
            make.width.equalTo(img.snp_height)
        }

        addSubview(count)
        count.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.right.equalTo(self.contentView.snp_right).offset(-HCChatSelectCell.OFFSET)
            make.width.equalTo(80)
        }

        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(HCChatSelectCell.OFFSET)
            make.right.equalTo(count.snp_left)
            make.left.equalTo(img.snp_right).offset(HCChatSelectCell.OFFSET)
            make.height.equalTo(self.snp_height).dividedBy(2).offset(-HCChatSelectCell.OFFSET)
        }

        addSubview(preview)
        preview.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-HCChatSelectCell.OFFSET)
            make.right.equalTo(count.snp_left)
            make.left.equalTo(img.snp_right).offset(HCChatSelectCell.OFFSET)
            make.height.equalTo(name)
        }
    }

    /// This shit is required.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: HCChatSelectViewController

class HCChatSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /// This will be the cell for reuse identifier for our table view.
    let KEY = "CONVO_CELL"

    /// The height for each cell.
    let CELL_HEIGHT = CGFloat(80)

    /// This table view will display a list of all the 
    /// available users to chat with.
    let tableView = UITableView()

    /// We will get this data from the data provider, for each
    /// value, we can get the user that is not the logged in user
    /// and display them, as well as the latest message in the array
    /// as the item for each row in the table view.
    var convos = Dictionary<Int, Array<HCMessage>>()

    /// Keep an array of keys into convos, this will allow us to index into
    /// the 'convo's array using an indexPath.
    var keys = Array<Int>()

    /// We will need a list of all the users so we can display their information,
    /// the 'getMessages' call will only give us the actual user class if there
    /// are actual messages in the conversation.
    var users = Array<HCUser>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()

        // setup the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(HCChatSelectCell.self, forCellReuseIdentifier: KEY)

        // add the table view
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        getConversations()
        getUsersList()
    }

    /// Retrieves the list of conversations from the server,
    /// then reloads the table view once we have the data.
    internal func getConversations() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        if let user = dp.user {
            dp.getMessages(user, completion: { (err, convos) in
                self.convos = convos
                for key in convos.keys {
                    self.keys.append(key)
                }

                self.tableView.reloadData()
            })
        }
    }

    /// Returns a list of all users in the current league
    internal func getUsersList() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.getAllUsers({ (err, users) in
            self.users = users
            self.tableView.reloadData()
        })
    }

    /// Find a user in our 'users' array for the given user id,
    /// if a user is not found, nil will be returned.
    internal func getUserByID(id: Int) -> HCUser? {
        for user in users {
            if user.id == id {
                return user
            }
        }

        return nil
    }

    // MARK: UITableViewDelegate/DataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CELL_HEIGHT
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(KEY, forIndexPath: indexPath) as! HCChatSelectCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor() : UIColor(white: 0.97, alpha: 1.0)

        let key = keys[indexPath.row]
        if let user = getUserByID(key) {
            cell.img.layer.cornerRadius = CELL_HEIGHT / 2 - CGFloat(HCChatSelectCell.OFFSET)
            cell.name.text = user.name
            cell.img.load(user.img_url)

            let count = convos[key]!.count
            cell.count.text = count > 0 ? String(count) : ""

            if let msg = convos[key]?.last {
                cell.preview.text = msg.message
            }
        }

        return cell
    }
}
