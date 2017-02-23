//
//  ColleagueViewController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 16/7/13.
//  Copyright © 2016年 CodeMarket.io. All rights reserved.
//

import Foundation
import UIKit



class ColleagueViewController: UIViewController {

//*****************************************************************
// MARK: - ViewDidLoad
//*****************************************************************


    
    
  
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        /*let myHTMLString:String! = "<h1>Hello Pizza!</h1>"
        webView.loadHTMLString(myHTMLString, baseURL: nil)*/
        
        let myURL = Bundle.main.url(forResource: "html/colleagueHTML", withExtension: "html")
        let requestObj = URLRequest(url: myURL!)
        webView.loadRequest(requestObj)
    }
    

}

