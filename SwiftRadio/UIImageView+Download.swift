//
//  UIImageView+AlbumArtDownload.swift
//  WGBB
//
//  Created by Zhongyi Yan on 5/21/16.
//  Copyright © 2016 Zhongyi Yan. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImageWithURL(_ url: URL, callback:@escaping (UIImage) -> ()) -> URLSessionDownloadTask {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url, completionHandler: {
            [weak self] url, response, error in
            
            if error == nil && url != nil {
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        
                        DispatchQueue.main.async {
                            
                            if let strongSelf = self {
                                strongSelf.image = image
                                callback(image)
                            }
                        }
                    }
                }
            }
        })
        
        downloadTask.resume()
        return downloadTask
    }
}


