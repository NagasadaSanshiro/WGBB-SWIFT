//
//  UIImage+DropShadow.swift
//  WGBB
//
//  Created by Zhongyi Yan on 5/21/16.
//  Copyright © 2016 Zhongyi Yan. All rights reserved.
//

import UIKit

extension UIImageView {

    // APPLY DROP SHADOW
    func applyShadow() {
		let layer           = self.layer
		layer.shadowColor   = UIColor.black.cgColor
		layer.shadowOffset  = CGSize(width: 0, height: 1)
		layer.shadowOpacity = 0.4
		layer.shadowRadius  = 2
    }

}
