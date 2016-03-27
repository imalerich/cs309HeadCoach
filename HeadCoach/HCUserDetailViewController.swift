//
//  HCUserDetailViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit

class HCUserDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    let tableView = UITableView();
    let model:[[UIColor]] = generateRandomData();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        self.view.addSubview(tableView)
        self.tableView.registerClass(UserDetailTableViewCell.classForCoder(), forCellReuseIdentifier: "DetailCell")
        tableView.snp_makeConstraints{ (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.view.snp_height)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell",forIndexPath:indexPath);
        
        return cell;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count;
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? UserDetailTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row);
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? UserDetailCollectionItemView
        
        cell!.backgroundColor = model[collectionView.tag][indexPath.item];
        cell!.setText("( ͡° ͜ʖ ͡°)");
        
        
        return cell!;
    }
}
