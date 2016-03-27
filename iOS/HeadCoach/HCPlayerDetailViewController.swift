//
//  HCPlayerDetailViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 1/27/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import RealmSwift
import ImageLoader

class HCPlayerDetailViewController: UIViewController, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {

    let colors = [UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.05), UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)]
    let progress = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let playerList: Results<(FDPlayer)> = try! Realm().objects(FDPlayer)
    let tableView = UITableView()
    let loading = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        view.backgroundColor = UIColor.whiteColor()
        if(playerList.count==0){
            view.addSubview(progress)
            progress.snp_makeConstraints(closure: {make in
                make.center.equalTo(self.view.snp_center)})
            progress.startAnimating()
            HCFantasyDataProvider.sharedInstance.getPlayerDetails(){(responseString:String?) in
                self.setUpTableView()
                self.progress.stopAnimating()
            }
        }else{
            setUpTableView()
        }
    }
    
    func setUpTableView(){
        self.progress.removeFromSuperview()
        self.view.addSubview(self.tableView)
        self.tableView.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "BasicCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp_makeConstraints(closure: { make in
            make.edges.equalTo(self.view)
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell") as! PlayerTableViewCell
        cell.setPlayer(playerList[indexPath.row])
        cell.backgroundColor = colors[indexPath.row % 2]
        cell.playerImage!.load(playerList[indexPath.row].photoURL)
        cell.playerImage!.layer.borderWidth=1.0
        cell.playerImage!.layer.masksToBounds=true
        cell.playerImage!.layer.borderColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.2 ).CGColor
        cell.playerImage!.layer.cornerRadius = 13
        cell.setNeedsLayout()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = HCPlayerMoreDetailController()
        vc.player = playerList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    class ImageLoader {
        
        var cache = NSCache()
        
        class var sharedLoader : ImageLoader {
            struct Static {
                static let instance : ImageLoader = ImageLoader()
            }
            return Static.instance
        }
        
        func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
                let data: NSData? = self.cache.objectForKey(urlString) as? NSData
                
                if let goodData = data {
                    let image = UIImage(data: goodData)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
                let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    if (error != nil) {
                        completionHandler(image: nil, url: urlString)
                        return
                    }
                    
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.cache.setObject(data!, forKey: urlString)
                        dispatch_async(dispatch_get_main_queue(), {() in
                            completionHandler(image: image, url: urlString)
                        })
                        return
                    }
                    
                })
                downloadTask.resume()
            })
            
        }
    }
    
    
    
    func filterList() { // should probably be called sort and not filter
       // fruitArr.sort() { $0.fruitName > $1.fruitName } // sort the fruit by name
       // fruitList.reloadData(); // notify the table view the data has changed
    }


}








