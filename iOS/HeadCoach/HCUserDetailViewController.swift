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

class HCUserDetailViewController: UIViewController,I3DragDataSource,UITableViewDelegate,UITableViewDataSource {
    
    var bench = UITableView();
    var active = UITableView();
    var gestureCoordinator = I3GestureCoordinator.init()

    var testarray:NSMutableArray = ["a","b","c","d"]
    var testarray2:NSMutableArray = ["e","f","g","h"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(active)
        self.view.addSubview(bench)
        gestureCoordinator = I3GestureCoordinator.basicGestureCoordinatorFromViewController(self, withCollections: [self.active,self.bench], withRecognizer: UILongPressGestureRecognizer.init())
        active.snp_makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(self.view.snp_bottom)
            make.width.equalTo(self.view.snp_width).multipliedBy(0.5)
            //            make.height.equalTo(self.view)
            //            make.width.equalTo(self.view).multipliedBy(0.5)
        }
        bench.snp_makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.right.equalTo(self.view.snp_right)
            make.bottom.equalTo(self.active.snp_bottom)
            make.left.equalTo(self.active.snp_right)
            //            make.height.equalTo(self.view)
            //            make.width.equalTo(self.view).multipliedBy(0.5)
        }
        active.registerClass(HCLeagueCell.classForCoder(), forCellReuseIdentifier: "test1")
        bench.registerClass(HCLeagueCell.classForCoder(), forCellReuseIdentifier: "test1")
        gestureCoordinator.renderDelegate = I3BasicRenderDelegate.init()
        gestureCoordinator.dragDataSource = self
        
        active.dataSource = self
        bench.dataSource = self
        bench.delegate = self
        active.delegate = self
        
    
    }
    
    internal func dataForCollection(collection:UIView) ->NSMutableArray{
        if (collection==self.active){
            return self.testarray
        }else{
            return self.testarray2         }
    }
    
    func canItemBeDraggedAt(at: NSIndexPath!, inCollection collection: UIView!) -> Bool {
        return true
    }
    
    func canItemFrom(from: NSIndexPath!, beRearrangedWithItemAt to: NSIndexPath!, inCollection collection: UIView!) -> Bool {
        return true
    }
    func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedAtPoint at: CGPoint, onCollection toCollection: UIView!) -> Bool {
        return true
    }
    
    func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedTo to: NSIndexPath!, onCollection toCollection: UIView!) -> Bool {
        print("flasjf;aldsfhsadflhasjfjah;df")
        return true
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("test1", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = self.dataForCollection(tableView)[indexPath.row] as! String
            cell.textLabel?.textColor = UIColor.blackColor()
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
