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
import RealmSwift

class HCUserDetailViewController: UIViewController,I3DragDataSource,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var bench = UITableView()
    var active = UITableView()
    let container = UIView()
    let profileImage = UIImageView()
    let activeLabel = UILabel()
    let benchLabel = UILabel()
    let userName = UILabel()
    let record = UILabel()
    let position = UILabel()
    var gestureCoordinator = I3GestureCoordinator.init()
    var imagePicker = UIImagePickerController()
    let upload = UIButton()
    
    var user:HCUser?
    //let parameters = ["client_id":c4299d0c77f8ddd,"client_secret":f4c1e5951d0b3444aebd1bfb3376b9313f75b1c2,]
    

    var testarray:NSMutableArray = []
    var testarray2:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(container)
        self.view.addSubview(profileImage)
        self.container.addSubview(activeLabel)
        self.container.addSubview(benchLabel)
        self.view.addSubview(userName)
        self.view.addSubview(record)
        self.view.addSubview(position)
        userName.text = HCHeadCoachDataProvider.sharedInstance.user!.name
        benchLabel.text = "Bench"
        activeLabel.text = "Active"
        view.backgroundColor = UIColor.whiteColor()
        bench.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        bench.layer.borderColor = UIColor.darkGrayColor().CGColor
        bench.layer.cornerRadius = 25
        bench.layer.borderWidth = 1
        active.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        active.layer.borderColor = UIColor.darkGrayColor().CGColor
        active.layer.cornerRadius = 25
        active.layer.borderWidth = 1
        self.active.tableFooterView = UIView()
        self.bench.tableFooterView = UIView()
        profileImage.layer.borderColor = UIColor.darkGrayColor().CGColor
        profileImage.layer.borderWidth = 1
        profileImage.layer.cornerRadius = 25
        profileImage.layer.masksToBounds = true
        self.view.addSubview(upload)
        upload.setTitle("Upload a Profile Picture", forState: .Normal)
        upload.setTitleColor(UIColor.footballColor(1.3), forState: .Normal)
        upload.titleLabel!.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        upload.addTarget(self, action: #selector(self.uploadAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        upload.layer.cornerRadius = 10
        upload.backgroundColor = UIColor.whiteColor()
        upload.layer.borderColor = UIColor.darkGrayColor().CGColor
        upload.layer.borderWidth = 1
        upload.titleLabel?.font = UIFont(name: (upload.titleLabel?.font?.fontName)!,size: 10)
        
        if(user?.name == HCHeadCoachDataProvider.sharedInstance.user!.name){
            upload.hidden = false
        }else{
            upload.hidden = true
        }
    
        profileImage.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).inset(70)
            make.left.equalTo(self.view.snp_left).inset(10)
            make.height.equalTo(75)
            make.width.equalTo(75)
        }
        
        upload.snp_makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.top.equalTo(profileImage.snp_bottom).inset(-3)
            make.left.equalTo(profileImage.snp_left)
        }
        
        container.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_centerY).multipliedBy(0.55)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp_bottom)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        
        self.container.addSubview(active)
        active.snp_makeConstraints { (make) in
            make.top.equalTo(self.container.snp_top).inset(30)
            make.left.equalTo(self.container).inset(5)
            make.bottom.equalTo(self.container).inset(5)
            make.width.equalTo(self.container).multipliedBy(0.5).inset(5)
            //            make.height.equalTo(self.view)
            //            make.width.equalTo(self.view).multipliedBy(0.5)
        }
        
        self.container.addSubview(bench)
        bench.snp_makeConstraints { (make) in
            make.top.equalTo(self.container.snp_top).inset(30)
            make.right.equalTo(self.container).inset(5)
            make.bottom.equalTo(self.container).inset(5)
            make.width.equalTo(self.container).multipliedBy(0.5).inset(5)
            //            make.height.equalTo(self.view)
            //            make.width.equalTo(self.view).multipliedBy(0.5)
        }
        
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(self.profileImage.snp_right).inset(-5)
            make.top.equalTo(self.profileImage.snp_top).inset(5)
            make.width.equalTo(100)
        }
        
        activeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.container.snp_top)
            make.centerX.equalTo(self.active.snp_centerX)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        benchLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.container.snp_top)
            make.centerX.equalTo(self.bench.snp_centerX)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        gestureCoordinator = I3GestureCoordinator.basicGestureCoordinatorFromViewController(self, withCollections:[self.active,self.bench], withRecognizer: UILongPressGestureRecognizer.init())
        active.registerClass(PlayerTableViewCell.classForCoder(), forCellReuseIdentifier: "test1")
        bench.registerClass(PlayerTableViewCell.classForCoder(), forCellReuseIdentifier: "test1")
        gestureCoordinator.renderDelegate = I3BasicRenderDelegate.init()
        gestureCoordinator.dragDataSource = self
        active.dataSource = self
        bench.dataSource = self
        bench.delegate = self
        active.delegate = self
        profileImage.load((user?.img_url)!)
        HCHeadCoachDataProvider.sharedInstance.getAllPlayersForUserFromLeague(HCHeadCoachDataProvider.sharedInstance.league!, user:HCHeadCoachDataProvider.sharedInstance.user! ) { (error, players) in
            for(var i = 0;i<players.count;i++){
                if (players[i].isOnBench){
                    self.testarray2.addObject(players[i])
                }else{
                    self.testarray.addObject(players[i])
                }
            }
            self.active.reloadData()
            self.bench.reloadData()
        }
    
    }
   
    internal func dataForCollection(collection:UIView) ->NSMutableArray{
        if (collection==self.active){
            return self.testarray
        }else{
            return self.testarray2         }
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
        
        if(fromTable==self.active){
            HCHeadCoachDataProvider.sharedInstance.movePlayerToBench(self.testarray[from.row] as! HCPlayer, league: HCHeadCoachDataProvider.sharedInstance.league!, completion: { (error) in
                print("move to bench")
                print(error)
            })
        }else{
            HCHeadCoachDataProvider.sharedInstance.movePlayerToActive(self.testarray2[from.row] as! HCPlayer, league: HCHeadCoachDataProvider.sharedInstance.league!, completion: { (error) in
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
        let realm = try! Realm()
        let player = self.dataForCollection(tableView)[indexPath.row] as! HCPlayer
        let temp = realm.objectForPrimaryKey(FDPlayer.self, key: player.fantasy_id)
        print(temp?.name)
        let vc = HCPlayerMoreDetailController()
        vc.player = temp
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("test1", forIndexPath: indexPath) as! PlayerTableViewCell
            let player = self.dataForCollection(tableView)[indexPath.row] as! HCPlayer
            let realm = try! Realm()
            let temp = realm.objectForPrimaryKey(FDPlayer.self, key: player.fantasy_id)
            cell.setPlayer(temp!)
            cell.playerImage.load((temp?.photoURL)!)
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            cell.preservesSuperviewLayoutMargins = false
            return cell
       
    }
    
    func dropItemAt(from: NSIndexPath!, fromCollection: UIView!, toPoint to: CGPoint, onCollection toCollection: UIView!) {
        
        let index = NSIndexPath(forItem: self.dataForCollection(toCollection).count, inSection: 0)
        
        self.dropItemAt(from, fromCollection: fromCollection, toItemAt: index, toCollection: toCollection)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.active){
            return self.testarray.count
        }else{
            return self.testarray2.count
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
                                print(error)
                                self.profileImage.load(url)
                                
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
 
}
