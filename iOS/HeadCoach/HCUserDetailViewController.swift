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
import RealmSwift

class HCUserDetailViewController: UIViewController,I3DragDataSource,UITableViewDelegate,UITableViewDataSource {
    
    var bench = UITableView()
    var active = UITableView()
    let container = UIView()
    let profileImage = UIImageView()
    var gestureCoordinator = I3GestureCoordinator.init()
    var user = ""

    var testarray:NSMutableArray = ["a","b"]
    var testarray2:NSMutableArray = ["c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(container)
        self.view.addSubview(profileImage)
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
        
        profileImage.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).inset(70)
            make.left.equalTo(self.view.snp_left).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        container.snp_makeConstraints { (make) in
            make.height.equalTo(350)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp_bottom)
            make.centerX.equalTo(self.view.snp_centerX)
        
        }
        
        self.container.addSubview(active)
        active.snp_makeConstraints { (make) in
            make.height.equalTo(345)
            make.left.equalTo(self.container).inset(5)
            make.bottom.equalTo(self.container).inset(5)
            make.width.equalTo(self.container).multipliedBy(0.5).inset(5)
            //            make.height.equalTo(self.view)
            //            make.width.equalTo(self.view).multipliedBy(0.5)
        }
        
        self.container.addSubview(bench)
        bench.snp_makeConstraints { (make) in
            make.height.equalTo(345)
            make.right.equalTo(self.container).inset(5)
            make.bottom.equalTo(self.container).inset(5)
            make.width.equalTo(self.container).multipliedBy(0.5).inset(5)
            //            make.height.equalTo(self.view)
            //            make.width.equalTo(self.view).multipliedBy(0.5)
        }
        gestureCoordinator = I3GestureCoordinator.basicGestureCoordinatorFromViewController(self, withCollections:[self.active,self.bench], withRecognizer: UILongPressGestureRecognizer.init())
        active.registerClass(HCLeagueCell.classForCoder(), forCellReuseIdentifier: "test1")
        bench.registerClass(HCLeagueCell.classForCoder(), forCellReuseIdentifier: "test1")
        gestureCoordinator.renderDelegate = I3BasicRenderDelegate.init()
        gestureCoordinator.dragDataSource = self
        active.dataSource = self
        bench.dataSource = self
        bench.delegate = self
        active.delegate = self
        profileImage.load("https://yt3.ggpht.com/-9JtIWfELi1A/AAAAAAAAAAI/AAAAAAAAAAA/sY8X2YGMGjU/s900-c-k-no/photo.jpg")
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
        if(user == HCHeadCoachDataProvider.sharedInstance.user!.name){
           return true
        }
        else {
           return false
        }
    }
    
    func canItemFrom(from: NSIndexPath!, beRearrangedWithItemAt to: NSIndexPath!, inCollection collection: UIView!) -> Bool {
        if(user == HCHeadCoachDataProvider.sharedInstance.user!.name){
            return true
        }
        else {
            return true
        }
    }
    func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedAtPoint at: CGPoint, onCollection toCollection: UIView!) -> Bool {
        if(user == HCHeadCoachDataProvider.sharedInstance.user!.name){
            return true
        }
        else {
            return true
        }
    }
    
    func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedTo to: NSIndexPath!, onCollection toCollection: UIView!) -> Bool {
        if(user == HCHeadCoachDataProvider.sharedInstance.user!.name){
            return true
        }
        else {
            return true
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
        print("rearrangeItemat")
        let targetTableView = collection as! UITableView
        let dafsdfasdf = self.dataForCollection(collection)
        dafsdfasdf.exchangeObjectAtIndex(to.row, withObjectAtIndex: from.row)
        targetTableView.reloadRowsAtIndexPaths([to,from], withRowAnimation: UITableViewRowAnimation.Fade)
      

    }
    
    
    func dropItemAt(from: NSIndexPath!, fromCollection: UIView!, toItemAt to: NSIndexPath!, toCollection: UIView!) {
        print("adfasdfasdfasdfasdfdsf")
        let fromTable = fromCollection as! UITableView
        let toTable = toCollection as! UITableView
        
        let fromDataset = self.dataForCollection(fromTable) as NSMutableArray
        let toDataset = self.dataForCollection(toTable) as NSMutableArray
        let dropDatum = fromDataset.objectAtIndex(from.row)
        
        fromDataset.removeObjectAtIndex(from.row)
        toDataset.insertObject(dropDatum, atIndex: to.row)
        
        fromTable.deleteRowsAtIndexPaths([from], withRowAnimation: UITableViewRowAnimation.Fade)
        toTable.insertRowsAtIndexPaths([to], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let vc = HCPlayerMoreDetailController()
//        vc.player = tableView[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("test1", forIndexPath: indexPath) as UITableViewCell
//            let player = self.dataForCollection(tableView)[indexPath.row] as! HCPlayer
//            cell.textLabel?.text = player.name
            cell.textLabel?.text = self.dataForCollection(tableView)[indexPath.row] as! String
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
    
  
    
    
    
    
    
 
}
