//
//  HCChatViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/18/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

// MARK: HCChatBubbleCell

class HCChatBubbleCell: UITableViewCell {

    /// Offset parameter for spacing between the text bubble and the edge of the cell.
    let HORIZ_INSETS = 16

    /// Offset parameter for vertical height between bubbles.
    let VERT_INSETS = 8

    /// Primary containing view for this cell.
    let dataView = UIView()

    /// The little tail view that we will attach to our speech bubble.
    let tail = UIImageView()

    /// This will contain the primary content source for our cell.
    let content = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None

        dataView.backgroundColor = UIColor(white: 229/255.0, alpha: 1.0)
        dataView.layer.cornerRadius = 20
        dataView.clipsToBounds = true

        content.numberOfLines = 0
        content.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)

        tail.image = UIImage(named: "tail")?.imageWithRenderingMode(.AlwaysTemplate)
        tail.tintColor = dataView.backgroundColor

        addSubview(dataView)
        dataView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(2 * HORIZ_INSETS)
            make.right.equalTo(self).offset(-HORIZ_INSETS)
            make.top.equalTo(self).offset(VERT_INSETS)
            make.bottom.equalTo(self).offset(-VERT_INSETS)
            make.height.greaterThanOrEqualTo(44)
        }

        insertSubview(tail, belowSubview: dataView)
        tail.snp_makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.centerX.equalTo(dataView.snp_right)
            make.bottom.equalTo(dataView.snp_bottom).offset(8)
        }

        dataView.addSubview(content)
        content.snp_makeConstraints { (make) in
            make.left.equalTo(dataView).offset(HORIZ_INSETS)
            make.right.equalTo(dataView).offset(-HORIZ_INSETS)
            make.top.equalTo(dataView).offset(VERT_INSETS)
            make.bottom.equalTo(dataView).offset(-VERT_INSETS)
        }
    }

    /// Set this to layout this bubble to distinguish the current user
    /// and the conversation partner.
    /// If 'user' is true, the bubble will point to the left and have a light
    /// gray color.
    /// If 'user' is false, the bubble will point to the right and have a
    /// light green color.
    func setBubbleDirection(user: Bool) {
        if user {
            dataView.backgroundColor = UIColor(white: 229/255.0, alpha: 1.0)
            tail.transform = CGAffineTransformMakeScale(-1, 1)

            tail.snp_removeConstraints()
            tail.snp_makeConstraints { (make) in
                make.width.height.equalTo(32)
                make.centerX.equalTo(dataView.snp_left)
                make.bottom.equalTo(dataView.snp_bottom).offset(8)
            }

            dataView.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(self).offset(HORIZ_INSETS)
                make.right.equalTo(self).offset(2 * -HORIZ_INSETS)
            })

            content.textColor = UIColor.blackColor()
            tail.tintColor = dataView.backgroundColor
        } else {
            dataView.backgroundColor = UIColor.footballColor(2.0)
            tail.transform = CGAffineTransformIdentity
            tail.snp_removeConstraints()
            tail.snp_makeConstraints { (make) in
                make.width.height.equalTo(32)
                make.centerX.equalTo(dataView.snp_right)
                make.bottom.equalTo(dataView.snp_bottom).offset(8)
            }

            dataView.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(self).offset(2 * HORIZ_INSETS)
                make.right.equalTo(self).offset(-HORIZ_INSETS)
            })

            // add a muted gradient
            content.textColor = UIColor.whiteColor()
        }

        tail.tintColor = dataView.backgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: HCCHatViewController

class HCChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /// Cell ID for cell reuse in our table view.
    let CELL_ID = "MessagingCell"

    /// The height of our text field.
    let CHAT_HEIGHT = CGFloat(60)

    // Offset bounds for the text field inside of the 'chatView'.
    let TEXT_OFFSET = CGFloat(8)

    /// The other user the current user is interacting with.
    var user = HCUser()

    /// This table view will display each message in this conversation.
    let tableView = UITableView()

    /// Background view that will contain the text field.
    let chatView = UIView()

    /// The textfield the user will use to show text.
    let text = UITextField()

    /// Height of the keyboard received from 'showKeyboard' this will be used for layout.
    var keyboardHeight = CGFloat(0)

    /// Whether or not the keybroad is visible.
    var keyboardVisible = false

    /// Limit how fast the user can send messages.
    var sendingMessage = false

    /// This is a list of all conversations, the data provider 
    /// will update this Dictionary periodically to account for new messages
    /// we will only display messages for the conversation array at index 'user.id'
    var convos = Dictionary<Int, Array<HCMessage>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user.name
        chatView.backgroundColor = UIColor(white: 244/255.0, alpha: 1.0)
        view.backgroundColor = chatView.backgroundColor

        view.addSubview(tableView)
        view.addSubview(chatView)

        // add the messaging tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 20
        tableView.registerClass(HCChatBubbleCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.backgroundColor = UIColor.whiteColor()

        tableView.snp_makeConstraints { (make) in
            make.top.right.left.equalTo(view)
            make.bottom.equalTo(chatView.snp_top)
        }

        // add the send button to the right side of the chat view
        let send = UIButton()
        send.setTitleColor(UIColor(white: 0.4, alpha: 1.0), forState: .Normal)
        send.setTitle("Send", forState: .Normal)
        send.addTarget(self, action: #selector(self.sendMessage), forControlEvents: .TouchUpInside)
        chatView.addSubview(send)

        send.snp_makeConstraints { (make) in
            make.right.bottom.equalTo(chatView).offset(-TEXT_OFFSET)
            make.top.equalTo(chatView).offset(TEXT_OFFSET)
            make.width.equalTo(50)
        }

        // add the insult icon
        let insult = UIButton()
        insult.imageView?.contentMode = .ScaleAspectFit
        insult.setImage(UIImage(named: "insult")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        insult.tintColor = UIColor(white: 0.6, alpha: 1.0)
        insult.addTarget(self, action: #selector(self.generateInsult), forControlEvents: .TouchUpInside)
        chatView.addSubview(insult)

        insult.snp_makeConstraints { (make) in
            make.left.equalTo(chatView).offset(TEXT_OFFSET)
            make.top.equalTo(chatView).offset(TEXT_OFFSET)
            make.bottom.equalTo(chatView).offset(-TEXT_OFFSET)
            make.width.equalTo(insult.snp_height).multipliedBy(0.5)
        }

        // add a top border to the chat view
        let top = UIView()
        top.backgroundColor = UIColor(white: 212/255.0, alpha: 1.0)
        chatView.addSubview(top)
        top.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(chatView)
            make.height.equalTo(1)
        }

        // make a container for the text box and our insult button.
        let ctext = UIView()
        ctext.layer.cornerRadius = 10
        ctext.layer.borderWidth = 1
        ctext.clipsToBounds = true
        ctext.backgroundColor = UIColor.whiteColor()
        ctext.layer.borderColor = UIColor(white: 212/255.0, alpha: 1.0).CGColor

        chatView.addSubview(ctext)
        ctext.snp_makeConstraints { (make) in
            make.top.equalTo(chatView).offset(TEXT_OFFSET)
            make.bottom.equalTo(chatView).offset(-TEXT_OFFSET)
            make.left.equalTo(insult.snp_right).offset(TEXT_OFFSET)
            make.right.equalTo(send.snp_left).offset(-TEXT_OFFSET)
        }

        ctext.addSubview(text)
        text.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(ctext)
            make.left.equalTo(ctext.snp_left).offset(6)
            make.right.equalTo(ctext.snp_right).offset(-6)
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.showKeyboard(_:)),
                                                         name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.hideKeyboard),
                                                         name: UIKeyboardWillHideNotification, object: nil)

        addProfileButton()
        let _ = NSTimer(timeInterval: 1, target: self, selector: #selector(self.updateConversations), userInfo: nil, repeats: true)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.readConversation(dp.user!, user1: user) { (err) in /* nothing to do */ }
        scrollToBottom(false)
    }

    /// Scroll to the bottom of the tableView, this has been pretty buggy for some reason.
    func scrollToBottom(animated: Bool) {
        if let messages = convos[user.id] {
            let count = messages.count
            if count > 0 {
                tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: count - 1, inSection: 0), atScrollPosition: .Bottom, animated: animated)
            }
        }
    }

    /// Periodically update the conversations so the output of
    /// the chat appears to be 'live'.
    internal func updateConversations() {
        let dp = HCHeadCoachDataProvider.sharedInstance

        if let user = dp.user {
            dp.getMessages(user, completion: { (err, convos) in
                self.convos = convos
                self.sendingMessage = false

                self.tableView.reloadData()
                self.scrollToBottom(false)
            })
        }
    }

    /// Removes all text from the current text field and replaces
    /// it with a random insult generated by Joe's insult generator.
    @objc private func generateInsult() {
        text.text = HCRandomInsultGenerator.sharedInstance.generateInsult()
        sendMessage()
    }

    /// Sends the message currently stored in the text view.
    @objc private func sendMessage() {
        // send the message and update the table view
        if let msg = text.text {
            // the user is not allowed to send an empty message
            // the user must not be currently sending a message
            if msg.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count == 0 ||
                    sendingMessage {
                return
            }

            sendingMessage = true

            let dp = HCHeadCoachDataProvider.sharedInstance
            dp.sendMessage(dp.user!, to: user, message: msg) { (err) in
                if !err {
                    self.updateConversations()
                }
            }
        } else {
            return
        }

        // animate the text box
        UIView.animateWithDuration(0.3, animations: {
            self.text.transform = CGAffineTransformMakeTranslation(0, -CGFloat(self.CHAT_HEIGHT))
        }) { (success) in
            self.text.text = ""
            self.text.transform = CGAffineTransformIdentity
        }
    }

    /// Adds a button to link to the players profile if and only if
    /// this player is a member of the current league.
    private func addProfileButton() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.getAllUsersForLeague(dp.league!) { (err, users) in
            for user in users {
                if user.id == self.user.id {
                    // add the profile button
                    let btn = UIBarButtonItem(title: "Profile", style: .Plain, target: nil, action: nil)
                    btn.action = #selector(self.goToProfile)
                    btn.target = self

                    self.navigationItem.rightBarButtonItem = btn

                    return
                }
            }
        }
    }

    /// Pushes the users profile onto the navigation stack. This is only
    /// valid if that user is in the current league.
    @objc private func goToProfile() {
        let vc = HCUserDetailViewController()
        vc.user = user

        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let y = self.view.frame.size.height - keyboardHeight - CHAT_HEIGHT
        chatView.frame = CGRectMake(0, y, view.frame.size.width, CHAT_HEIGHT)
    }

    // MARK: Keyboard layout adjustments

    /// Adjusts view layouts to account for the keyboard.
    @objc private func showKeyboard(data: NSNotification) {
        // keyboard is already visible, nothing to do
        if keyboardVisible {
            return
        }

        let info = data.userInfo
        let val = info![UIKeyboardFrameBeginUserInfoKey]
        let rect = val?.CGRectValue()

        keyboardVisible = true
        keyboardHeight = rect!.size.height + 9

        UIView.animateWithDuration(0.3) {
            let y = self.view.frame.size.height - self.keyboardHeight - self.CHAT_HEIGHT
            self.chatView.frame = CGRectMake(0, y, self.view.frame.size.width, self.CHAT_HEIGHT)
        }
    }

    /// Resets views after the keyboard is hidden.
    @objc private func hideKeyboard() {
        keyboardVisible = false
        keyboardHeight = 0

        UIView.animateWithDuration(0.3) {
            let y = self.view.frame.size.height - self.keyboardHeight - self.CHAT_HEIGHT
            self.chatView.frame = CGRectMake(0, y, self.view.frame.size.width, self.CHAT_HEIGHT)
        }
    }

    // MARK: UITableView Delegate & Data Source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = convos[user.id] {
            return messages.count
        }

        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID, forIndexPath: indexPath) as! HCChatBubbleCell

        if let messages = convos[user.id] {
            let msg = messages[indexPath.row]
            cell.setBubbleDirection(msg.to.id == user.id)
            cell.content.text = msg.message
        }

        return cell
    }
}
