//
//  ActivityMenuViewController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 16/7/8.
//  Copyright © 2016年 CodeMarket.io. All rights reserved.
//

import Foundation
import UIKit



class ActivityMenuViewController: UIViewController {
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    

    //@IBOutlet weak var activityText: UITextView!
    
    @IBOutlet var webView: UIWebView!
    //@IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*let screenSize:CGRect = UIScreen.main.bounds
        let imageView = UIImageView(image: UIImage(named: "activity_Text"))
        imageView.frame = CGRect(x:0, y:0, width: screenSize.width, height: 2180)
        activityText.scrollsToTop = true
        activityText.addSubview(imageView)
        activityText.isEditable = false
        activityText.contentOffset = CGPoint(x: 0, y: 0)*/
        
        /*let myURL = NSBundle.mainBundle().URLForResource("html/activityHTML", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        webView.loadRequest(requestObj)
         */
        
        //activityText.text.appendContentsOf("fgjfgj")
        /*let attachment = NSTextAttachment()
        
        
        attachment.image = UIImage(named: "activity_Text")
        attachment.bounds = CGRect( x:0, y:50, width: screenSize.width, height: 300 )
        let attStr = NSAttributedString(attachment: attachment)
        
        var mutableStr = NSMutableAttributedString(attributedString: activityText.attributedText)
        let selectedRange = activityText.selectedRange
        
        mutableStr.insert(attStr, at: selectedRange.location )*/
        
        let myURL = Bundle.main.url(forResource: "html/activityHTML", withExtension: "html")
        let requestObj = URLRequest(url: myURL!)
        webView.loadRequest(requestObj)
    }
    /*override func viewWillAppear(_ animated: Bool) {
        activityText.isScrollEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        
        activityText.isScrollEnabled = true
    }*/
}

