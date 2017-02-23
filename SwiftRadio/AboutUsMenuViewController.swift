//
//  AboutUsMenuViewController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 16/7/7.
//  Copyright © 2016年 CodeMarket.io. All rights reserved.
//

import Foundation
import UIKit



class AboutUsMenuViewController: UIViewController {
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    
   @IBOutlet weak var textView: UITextView!
    @IBOutlet var webView: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
       navigationController?.navigationBar.tintColor = UIColor.white
        
        /*let imageView = UIImageView();
        let image = UIImage(named: "aboutUs");
        imageView.image = image;
        let path = UIBezierPath(rect: CGRectMake(0, 0, 200, 200))
        textView.textContainer.exclusionPaths = [path]
        textView.addSubview(imageView)*/
        
        let screenSize:CGRect = UIScreen.main.bounds
        let imageView = UIImageView(image: UIImage(named: "aboutUs"))
        imageView.frame = CGRect(x:0, y:10, width: screenSize.width, height: 200)
        //let path = UIBezierPath(rect: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        
        //textView.textContainer.exclusionPaths = [path]
        textView.scrollsToTop = true
        textView.addSubview(imageView)
        textView.isEditable = false
        //var offSet = textView.contentOffset.x
        
        textView.contentOffset = CGPoint(x: 0, y: 0)
       
        */   //Nov 23 2016
        
        
        
        //textView.selectable = false
        
        //imageView.frame = CGRect(x:0, y:-30, width: 200, height: 200)
        //textView.addSubview(imageView)
        
        /*let textAttachment = NSTextAttachment()
        let attributedString = NSMutableAttributedString(string: "")
        textAttachment.image = UIImage(named:"aboutUs")!
        let oldWidth = textAttachment.image!.size.width;
        let scaleFactor = oldWidth / (textView.frame.size.width - 10);
        textAttachment.image = UIImage(CGImage: textAttachment.image!.CGImage!, scale: scaleFactor, orientation: .Up)
        var attrStringWithImage = NSAttributedString(attachment: textAttachment)
        attributedString.replaceCharactersInRange(NSMakeRange(6, 1), withAttributedString: attrStringWithImage)
         */
         
        //textView.attributedText = attributedString;
        
        //textView.addSubview(imageView)
        //let leftView = UIView.init(frame: CGRectMake(10, 0, 30, 30))
        
        
        /*var viewFrame:CGRect = (self.tabBarController?.tabBar.frame)!
        
        viewFrame.size.height = 80
        //self.tabBarController?.tabBar.frame = viewFrame
        self.tabBarController?.tabBar.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 300)*/
        
        
       //self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - 160
        
        let myURL = Bundle.main.url(forResource: "html/aboutHTML", withExtension: "html")
        let requestObj = URLRequest(url: myURL!)
        webView.loadRequest(requestObj)
    }
    /*override func viewWillAppear(_ animated: Bool) {
        textView.isScrollEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        
        textView.isScrollEnabled = true
    }*/
}
