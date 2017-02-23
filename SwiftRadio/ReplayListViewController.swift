//
//  ReplayListViewController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 16/7/16.
//  Copyright © 2016年 CodeMarket.io. All rights reserved.
//

import Foundation
import UIKit

class RemoteAPI {
   /*  func getData(completionHandler: ((NSArray!, NSError!) -> Void)!) -> Void {
       var response: NSURLResponse? = nil
        var error: NSError? = nil
        
        let url: NSURL = NSURL(string: "http://itunes.apple.com/search?term=Turistforeningen&media=software")!
        let ses = NSURLSession.sharedSession()
        let task = ses.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                return completionHandler(nil, error)
            }
            
            var error: NSError?
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? Array<NSDictionary>
            
            if (error != nil) {
                return completionHandler(nil, error)
            } else {
                return completionHandler(json["results"] as [NSDictionary], nil)
            }
        })
        task.resume()
    }*/
}

var api = RemoteAPI()


class ReplayListViewController: UIViewController {

//*****************************************************************
// MARK: - ViewDidLoad
//*****************************************************************
    @IBOutlet var tableView: UITableView!


}