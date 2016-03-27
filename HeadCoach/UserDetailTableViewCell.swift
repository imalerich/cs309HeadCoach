//
//  UserDetailTableViewCell.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/9/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class UserDetailTableViewCell: UITableViewCell{

    let collectionView = UICollectionView.init(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: UICollectionViewFlowLayout.init())

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.addSubview(collectionView)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(60, 60)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        self.collectionView.registerClass(UserDetailCollectionItemView.classForCoder(), forCellWithReuseIdentifier: "Cell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets the collectionView delegate, datasource, and tag
    /// - Parameters:
    ///     -dataSourceDelegate: the delegate and datasource destination
    ///     -row: the row of the current tableview cell
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int){
            
            collectionView.delegate = dataSourceDelegate;
            collectionView.dataSource = dataSourceDelegate;
            collectionView.tag = row;
            collectionView.reloadData();
    }
    
}
