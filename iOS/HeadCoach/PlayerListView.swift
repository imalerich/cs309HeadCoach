//
//  PlayerListView.swift
//  HeadCoach
//
//  Created by Davor Civsa on 4/4/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PlayerListView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: HCPlayerDetailViewController!
    
    let colors = [UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.05), UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)]
    let progress = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var tableView = UITableView()
    let loading = UITextView()
    let topBar = UIView()
    let filterLabel = UILabel()
    var filterButton = UIButton.init(type: UIButtonType.System)
    let sortLabel = UILabel()
    var sortButton = UIButton.init(type: UIButtonType.System)
    let picker = UIPickerView()
    let pickerFilterData = ["All", "QB", "TE"]
    let pickerSortData = ["A-Z", "Z-A"]
    var pickerDataSource: [String]!
    var isLoading = false
    
    override init (frame : CGRect){
        super.init(frame: frame)
    }
    
    init (frame : CGRect, delegate: HCPlayerDetailViewController) {
        self.delegate = delegate
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addCustomView(){
        tableView = UITableView()
        setUpTableView()
        addSubview(tableView)
        setUpTableView()
        
        topBar.backgroundColor = UIColor.whiteColor()
        addSubview(topBar)
        
        filterLabel.text = "Filter by:"
        filterLabel.textColor = UIColor.darkTextColor()
        filterLabel.textAlignment = .Right
        filterLabel.font = filterLabel.font.fontWithSize(12)
        topBar.addSubview(filterLabel)
        
        filterButton.titleLabel!.font = filterButton.titleLabel!.font.fontWithSize(12)
        filterButton.titleLabel!.textAlignment = .Left
        topBar.addSubview(filterButton)
        
        sortLabel.text = "Sort by:"
        sortLabel.textColor = UIColor.darkTextColor()
        sortLabel.textAlignment = .Right
        sortLabel.font = sortLabel.font.fontWithSize(12)
        topBar.addSubview(sortLabel)
        
        sortButton.titleLabel!.font = sortButton.titleLabel!.font.fontWithSize(12)
        sortButton.titleLabel!.textAlignment = .Left
        topBar.addSubview(sortButton)
        
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.whiteColor()
        picker.hidden = true
        addSubview(picker)
        setConstraints()
    }
    
    func setLoading(isLoading: Bool){
        self.isLoading = isLoading
        if(isLoading){
            addSubview(progress)
            progress.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self)
            })
            progress.startAnimating()
        }else{
            progress.removeFromSuperview()
        }
    }
    
    func setUpTableView(){
        tableView.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.delegate = self.delegate
        tableView.dataSource = self.delegate
        delegate!.filterPlayer(delegate.filterType)
        delegate!.sortPlayers(delegate.sortType)
        pickerDataSource = pickerSortData
        setNeedsLayout()
    }
    
    func setConstraints(){
        topBar.snp_makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.05)
            make.top.equalTo(self)
        }
        tableView.snp_makeConstraints(closure: { make in
            make.top.equalTo(topBar.snp_bottom)
            make.width.equalTo(self.snp_width)
            make.height.equalTo(self.snp_height)
        })
        sortLabel.snp_makeConstraints { (make) in
            make.width.equalTo(topBar).multipliedBy(0.25)
            make.left.equalTo(topBar)
            make.centerY.equalTo(topBar)
        }
        sortButton.snp_makeConstraints { (make) in
            make.width.equalTo(sortLabel)
            make.left.equalTo(sortLabel.snp_right)
            make.height.equalTo(topBar)
        }
        filterLabel.snp_makeConstraints { (make) in
            make.width.equalTo(sortLabel)
            make.left.equalTo(sortButton.snp_right)
            make.centerY.equalTo(topBar)
        }
        filterButton.snp_makeConstraints { (make) in
            make.width.equalTo(sortLabel)
            make.left.equalTo(filterLabel.snp_right)
            make.height.equalTo(topBar)
        }
        picker.snp_makeConstraints { (make) in
            make.width.equalTo(self.snp_width)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(self.snp_bottom)
            make.height.equalTo(self.snp_height).multipliedBy(0.3)
        }
        
    }
    
    func updateButtonText(sortType: FDPlayer.SortType, filterType: FDPlayer.PositionFilterType){
        switch(sortType){
        case FDPlayer.SortType.AlphaAZ:
            sortButton.setAttributedTitle(NSAttributedString(string: "A-Z"), forState: UIControlState.Normal)
        case FDPlayer.SortType.AlphaZA:
            sortButton.setAttributedTitle(NSAttributedString(string: "Z-A"), forState: UIControlState.Normal)
        }
        switch(filterType){
        case FDPlayer.PositionFilterType.All:
            filterButton.setAttributedTitle(NSAttributedString(string: "All"), forState: UIControlState.Normal)
        case FDPlayer.PositionFilterType.QB:
            filterButton.setAttributedTitle(NSAttributedString(string: "QB"), forState: UIControlState.Normal)
        case FDPlayer.PositionFilterType.TE:
            filterButton.setAttributedTitle(NSAttributedString(string: "TE"), forState: UIControlState.Normal)
        }
        setNeedsLayout()
    }
    
    func updateTopBar(isVisible v:Bool){
        topBar.hidden = v
        setNeedsLayout()
    }
    
    func showPicker(forDataSource source: [String]){
        pickerDataSource = source
        picker.hidden = false
        picker.reloadAllComponents()
        setNeedsLayout()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.capacity
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerDataSource == pickerSortData){
            delegate.filterPlayer(delegate.filterType)
            switch(pickerDataSource[row]){
                case "A-Z": delegate.sortPlayers(FDPlayer.SortType.AlphaAZ)
                case "Z-A": delegate.sortPlayers(FDPlayer.SortType.AlphaZA)
            default: break
            }
        }else{
            switch(pickerDataSource[row]){
                case "All": delegate.filterPlayer(FDPlayer.PositionFilterType.All)
                case "QB": delegate.filterPlayer(FDPlayer.PositionFilterType.QB)
                case "TE": delegate.filterPlayer(FDPlayer.PositionFilterType.TE)
            default: break
            }
            delegate.sortPlayers(delegate.sortType)
        }
        picker.hidden = true
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerDataSource[row])
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}
