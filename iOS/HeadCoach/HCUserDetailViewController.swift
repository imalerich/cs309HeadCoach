//
//  HCUserDetailViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit
import BetweenKit
import Foundation
import Alamofire

// MARK: HCUserDetailPlayerCell

class HCUserDetailPlayerCell: UITableViewCell {

    let OFFSET = 4

    /// The position this player fills in a users roster.
    let pos = UILabel()

    /// Photo for this player.
    let photo = UIImageView()

    /// Name label for this player.
    let name = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        
        initViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initViews(){
        name.text = "Name"
        name.textAlignment = .Left
        name.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)

        pos.textAlignment = .Center
        pos.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        pos.textColor = UIColor(white: 0.4, alpha: 1.0)
        pos.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        photo.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        photo.contentMode = .ScaleAspectFill
        photo.clipsToBounds = true
    }
    
    internal func layoutViews(){
        addSubview(photo)
        photo.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.height.equalTo(photo.snp_width)
        }

        // add a little right border next to the photo
        let right = UIView()
        right.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        addSubview(right)
        right.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(photo)
            make.right.equalTo(photo.snp_right)
            make.width.equalTo(1)
        }

        addSubview(pos)
        pos.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(OFFSET)
            make.right.equalTo(self.contentView).offset(-OFFSET)
            make.bottom.equalTo(self.contentView).offset(-OFFSET)
            make.width.equalTo(pos.snp_height).multipliedBy(1.2)
        }

        addSubview(name)
        name.snp_makeConstraints { (make) in
            make.right.equalTo(pos.snp_left).offset(OFFSET)
            make.left.equalTo(photo.snp_right).offset(OFFSET)
            make.bottom.top.equalTo(self)
        }

        // add a little bottom border
        let bottom = UIView()
        bottom.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        addSubview(bottom)
        bottom.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    func setPlayer(player: HCPlayer){
        photo.load(player.img)
        name.text = player.name
        pos.text = HCPositionUtil.positionToString(player.position)
    }
}

// MARK: HCUserDetailViewController

class HCUserDetailViewController: UIViewController,I3DragDataSource,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    /// Height of the top bar containing the user details information
    let USER_DETAILS_HEIGHT = 100

    /// Below that will be the two action buttons 
    /// to change the profile picture, and the drafting linuxb
    let OPTIONS_HEIGHT = 50

    /// Height for the 'active/bench' labels.
    let TABLE_LABLE_HEIGHT = 30

    let container = UIView()
    let bench = UITableView()
    let active = UITableView()

    let profileImage = UIImageView()
    let activeLabel = UILabel()
    let benchLabel = UILabel()
    let record = UILabel()
    let position = UILabel()

    var gestureCoordinator = I3GestureCoordinator.init()
    var imagePicker = UIImagePickerController()
    let upload = UIButton()
    let draft = UIButton()
    var user:HCUser?

    var activePlayers = NSMutableArray()
    var benchedPlayers = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false

        // ADD ALL THE SUBVIEWS
        view.addSubview(container)
        view.addSubview(profileImage)
        view.addSubview(record)
        view.addSubview(position)
        view.addSubview(draft)
        view.addSubview(upload)

        // add the subviews for the container
        container.addSubview(activeLabel)
        container.addSubview(benchLabel)
        container.addSubview(bench)
        container.addSubview(active)

        edgesForExtendedLayout = .None
        benchLabel.text = "Bench"
        activeLabel.text = "Active"
        activeLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        benchLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        activeLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
        benchLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
        activeLabel.textAlignment = .Center
        benchLabel.textAlignment = .Center

        bench.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        active.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        bench.separatorStyle = .None
        active.separatorStyle = .None
        
        profileImage.contentMode = .ScaleAspectFill
        profileImage.clipsToBounds = true
        record.numberOfLines = 3
        record.textColor = UIColor.whiteColor()
        record.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)

        upload.setTitle("Change Picture", forState: .Normal)
        upload.addTarget(self, action: #selector(self.uploadAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        upload.titleLabel?.textAlignment = .Center

        draft.setTitle("Draft Players", forState: .Normal)
        draft.addTarget(self, action: #selector(self.draftAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        draft.titleLabel?.textAlignment = .Center

        upload.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        upload.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        upload.backgroundColor = UIColor.footballColor(0.8)

        draft.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        draft.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        draft.backgroundColor = UIColor.footballColor(0.6)

        HCHeadCoachDataProvider.sharedInstance.getUserStats(user!, league: HCHeadCoachDataProvider.sharedInstance.league!) { (stats) in
            let temp = "Wins " + String(self.user!.stats!.wins) + "\nLoses " + String(self.user!.stats!.loses) + "\nDraws " + String(self.user!.stats!.draws)
            self.record.text = temp
        }
        
        if user?.name == HCHeadCoachDataProvider.sharedInstance.user!.name {
            upload.hidden = false
            draft.hidden = false
        } else {
            upload.hidden = true
            draft.hidden = true

            draft.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })

            upload.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
        }


        // first is the details bar
    
        profileImage.snp_makeConstraints { (make) in
            make.top.left.equalTo(view)
            make.height.width.equalTo(USER_DETAILS_HEIGHT)
        }

        record.snp_makeConstraints { (make) in
            make.top.height.equalTo(profileImage)
            make.right.equalTo(view)
            make.left.equalTo(profileImage.snp_right).offset(12)
        }

        // add a little background image behind the record view
        let bg = UIView()
        bg.backgroundColor = UIColor.blackColor()
        view.insertSubview(bg, belowSubview: record)
        bg.snp_makeConstraints { (make) in
            make.top.height.equalTo(profileImage)
            make.right.equalTo(view)
            make.left.equalTo(profileImage.snp_right)
        }

        let img_bg = UIImageView(image: UIImage(named: "blurred_background"))
        img_bg.contentMode = .ScaleAspectFill
        img_bg.clipsToBounds = true
        img_bg.alpha = 0.4
        view.insertSubview(img_bg, aboveSubview: record)
        img_bg.snp_makeConstraints { (make) in
            make.edges.equalTo(bg)
        }

        // next we have the options bar
        
        draft.snp_makeConstraints { (make) in
            make.top.equalTo(record.snp_bottom)
            make.right.equalTo(self.view.snp_right)
            make.width.equalTo(self.view.snp_width).dividedBy(2)
            make.height.equalTo(OPTIONS_HEIGHT)
        }
        
        upload.snp_makeConstraints { (make) in
            make.top.equalTo(record.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.width.equalTo(self.view.snp_width).dividedBy(2)
            make.height.equalTo(OPTIONS_HEIGHT)
        }

        // TODO - current draft status bar

        // and last we have the table views
        
        container.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(upload.snp_bottom)
            make.bottom.equalTo(view.snp_bottom)
        }

        // Layout the labels for the table views

        activeLabel.snp_makeConstraints { (make) in
            make.height.equalTo(TABLE_LABLE_HEIGHT)
            make.top.equalTo(container)
            make.centerX.equalTo(active.snp_centerX)
            make.width.equalTo(container.snp_width).dividedBy(2)
        }
        
        benchLabel.snp_makeConstraints { (make) in
            make.height.equalTo(TABLE_LABLE_HEIGHT)
            make.top.equalTo(container)
            make.centerX.equalTo(bench.snp_centerX)
            make.width.equalTo(container.snp_width).dividedBy(2)
        }

        // add a little divider underneath the labels
        let labelBottom = UIView()
        labelBottom.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        container.addSubview(labelBottom)
        labelBottom.snp_makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.bottom.equalTo(benchLabel.snp_bottom)
            make.height.equalTo(1)
        }

        // Layout the actual Table Views

        active.snp_makeConstraints { (make) in
            make.top.equalTo(activeLabel.snp_bottom)
            make.left.equalTo(container)
            make.bottom.equalTo(container)
            make.width.equalTo(container).multipliedBy(0.5)
        }
        
        bench.snp_makeConstraints { (make) in
            make.top.equalTo(benchLabel.snp_bottom)
            make.right.equalTo(container)
            make.bottom.equalTo(container)
            make.width.equalTo(container).multipliedBy(0.5)
        }

        // Add a little divider between the bench and active table views.
        let divider = UIView()
        divider.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        container.addSubview(divider)
        divider.snp_makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(container)
            make.width.equalTo(1)
        }

        // I do not have any idea what this shit is trying to do.
        
        gestureCoordinator = I3GestureCoordinator.basicGestureCoordinatorFromViewController(self, withCollections:[self.active,self.bench], withRecognizer: UILongPressGestureRecognizer.init())
        active.registerClass(HCUserDetailPlayerCell.self, forCellReuseIdentifier: "test1")
        bench.registerClass(HCUserDetailPlayerCell.self, forCellReuseIdentifier: "test1")
        gestureCoordinator.renderDelegate = I3BasicRenderDelegate.init()
        gestureCoordinator.dragDataSource = self
        active.dataSource = self
        bench.dataSource = self
        bench.delegate = self
        active.delegate = self
        profileImage.load((user?.img_url)!)

        loadCurrentDraft()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.loadCurrentDraft), name:
            HCPlayerMoreDetailController.DRAFT_NOTIFICATION,
            object: nil)
    }

    /// Reload the current draft, we will need to do this every time the current 
    /// players draft changes.
    func loadCurrentDraft() {
        let dp = HCHeadCoachDataProvider.sharedInstance
        dp.getAllPlayersForUserFromLeague(dp.league!, user: self.user! ) { (error, players) in
            // remove all the players we had in our arrays
            self.benchedPlayers.removeAllObjects()
            self.activePlayers.removeAllObjects()

            // and add all the new ones
            for player in players {
                if (player.isOnBench) {
                    self.benchedPlayers.addObject(player)
                } else {
                    self.activePlayers.addObject(player)
                }
            }

            // data source has changed, reload the table views
            self.active.reloadData()
            self.bench.reloadData()
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.title = self.user?.name
    }
   
    internal func dataForCollection(collection:UIView) -> NSMutableArray {
        if (collection==self.active) {
            return self.activePlayers
        } else {
            return self.benchedPlayers
        }
    }
    
    func canItemBeDraggedAt(at: NSIndexPath!, inCollection collection: UIView!) -> Bool {
        if(user?.name == HCHeadCoachDataProvider.sharedInstance.user!.name){
           return true
        }
        else {
           return false
        }
    }
    
    func canItemFrom(from: NSIndexPath!, beRearrangedWithItemAt to: NSIndexPath!, inCollection collection: UIView!) -> Bool {
        if(user!.name == HCHeadCoachDataProvider.sharedInstance.user!.name){
            return true
        }
        else {
            return false
        }
        
        
    }
    func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedAtPoint at: CGPoint, onCollection toCollection: UIView!) -> Bool {
        if(user!.name == HCHeadCoachDataProvider.sharedInstance.user!.name){
            return true
        }
        else {
            return false
        }
    }
    
    func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedTo to: NSIndexPath!, onCollection toCollection: UIView!) -> Bool {
        if(user!.name == HCHeadCoachDataProvider.sharedInstance.user!.name){
            return true
        }
        else {
            return false
        }
    }
    
    func deleteItemAt(at: NSIndexPath!, inCollection collection: UIView!) {
        let fromTable = collection as! UITableView
        let templist = self.dataForCollection(collection)
        print(at.row)
        templist.removeObjectAtIndex(at.row)
        fromTable.deleteRowsAtIndexPaths([NSIndexPath(forRow: at.row,inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func rearrangeItemAt(from: NSIndexPath!, withItemAt to: NSIndexPath!, inCollection collection: UIView!) {
        let targetTableView = collection as! UITableView
        let temp = self.dataForCollection(collection)
        temp.exchangeObjectAtIndex(to.row, withObjectAtIndex: from.row)
        targetTableView.reloadRowsAtIndexPaths([to,from], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func dropItemAt(from: NSIndexPath!, fromCollection: UIView!, toItemAt to: NSIndexPath!, toCollection: UIView!) {
        let fromTable = fromCollection as! UITableView
        let toTable = toCollection as! UITableView
        
        if(fromTable==self.active) {
            HCHeadCoachDataProvider.sharedInstance.movePlayerToBench(self.activePlayers[from.row] as! HCPlayer, league: HCHeadCoachDataProvider.sharedInstance.league!, completion: { (error) in
                print("move to bench")
                print(error)
            })

        } else {
            HCHeadCoachDataProvider.sharedInstance.movePlayerToActive(self.benchedPlayers[from.row] as! HCPlayer, league: HCHeadCoachDataProvider.sharedInstance.league!, completion: { (error) in
                print("move to active")
                print(error)
            })
        }
        
        let fromDataset = self.dataForCollection(fromTable) as NSMutableArray
        let toDataset = self.dataForCollection(toTable) as NSMutableArray
        let dropDatum = fromDataset.objectAtIndex(from.row)
        fromDataset.removeObjectAtIndex(from.row)
        toDataset.insertObject(dropDatum, atIndex: to.row)
        
        fromTable.deleteRowsAtIndexPaths([from], withRowAnimation: UITableViewRowAnimation.Fade)
        toTable.insertRowsAtIndexPaths([to], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let player = self.dataForCollection(tableView)[indexPath.row] as! HCPlayer
        let vc = HCPlayerMoreDetailController(forHCPlayer: player)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("test1", forIndexPath: indexPath) as! HCUserDetailPlayerCell
        let player = self.dataForCollection(tableView)[indexPath.row] as! HCPlayer

        // I assume this is here for a reason
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false

        // but this is all we really need
        cell.backgroundColor = UIColor.whiteColor()
        cell.setPlayer(player)

        return cell
    }
    
    func dropItemAt(from: NSIndexPath!, fromCollection: UIView!, toPoint to: CGPoint, onCollection toCollection: UIView!) {
        
        let index = NSIndexPath(forItem: self.dataForCollection(toCollection).count, inSection: 0)
        
        self.dropItemAt(from, fromCollection: fromCollection, toItemAt: index, toCollection: toCollection)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.active) {
            return self.activePlayers.count
        } else {
            return self.benchedPlayers.count
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        //let base64String = UIImageJPEGRepresentation(image, 1.0)?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let parameters = ["image": base64String,"type": "base64"]
        let headers = ["Authorization": "Client-ID c4299d0c77f8ddd"]
        Alamofire.request(.POST, "https://api.imgur.com/3/upload", parameters: parameters,headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    print(json)
                    if let data = json["data"] as? Dictionary<String,AnyObject>{
                        if let url = data["link"]as? String{
                            print(url)
                            HCHeadCoachDataProvider.sharedInstance.setUserProfileImage(self.user!, imgUrl: url, completion: { (error) in
                                self.user?.img_url = url
                                self.profileImage.load(url)
                                HCHeadCoachDataProvider.sharedInstance.user = self.user
                        
                            })
                        }
                    }
                }
        }
        
    }
    
    func uploadAction(sender: UIButton!){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func draftAction(sender: UIButton!){
        let vc = HCPlayerListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
 
}
