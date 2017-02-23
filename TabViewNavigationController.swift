//
//  TabViewNavigationController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 16/7/15.
//  Copyright © 2016年 CodeMarket.io. All rights reserved.
//

import Foundation
import UIKit



class TabViewNavigationController: UIViewController {
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    

    @IBOutlet var textView: UITextView!
   
    
        override func viewDidLoad() {
        super.viewDidLoad()

            
            
            textView.scrollsToTop = true
            textView.isEditable = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.isScrollEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        
        textView.isScrollEnabled = true
    }

    }
