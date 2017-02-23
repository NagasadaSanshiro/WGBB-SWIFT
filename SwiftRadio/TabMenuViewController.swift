//
//  TabMenuViewController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 16/7/23.
//  Copyright © 2016年 CodeMarket.io. All rights reserved.
//

import Foundation
import Foundation
import UIKit



class TabMenuViewController: UITabBarController {
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        
        /*var viewFrame:CGRect = (self.tabBarController?.tabBar.frame)!
        viewFrame.size.height = 80
        //self.tabBarController?.tabBar.frame = viewFrame
        self.tabBarController?.tabBar.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 300)*/
        
    }
    
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBarController?.tabBar.frame
        // - 40 is editable , I think the default value is around 50 px, below lowers the tabbar and above increases the tab bar size
        tabFrame?.size.height = 200
        tabFrame?.origin.y = self.view.frame.size.height - 200
        
        self.tabBarController?.tabBar.frame = tabFrame!
    }
    
}
