//
//  DataManager.swift
//  WGBB
//
//  Created by Zhongyi Yan on 5/21/16.
//  Copyright © 2016 Zhongyi Yan. All rights reserved.
//

import UIKit

class DataManager {
    
    //*****************************************************************
    // Helper class to get either local or remote JSON
    //*****************************************************************
    
    class func getStationDataWithSuccess(_ success: @escaping ((_ metaData: Data?) -> Void)) {

        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            if useLocalStations {
                getDataFromFileWithSuccess() { data in
                    success(data)
                }
            } else {
                loadDataFromURL(URL(string: stationDataURL)!) { data, error in
                    if let urlData = data {
                        success(urlData)
                    }
                }
            }
        }
    }
    
    //*****************************************************************
    // Load local JSON Data
    //*****************************************************************
    
    class func getDataFromFileWithSuccess(_ success: (_ data: Data) -> Void) {
        
        if let filePath = Bundle.main.path(forResource: "stations", ofType:"json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath),
                    options: NSData.ReadingOptions.uncached)
                success(data)
            } catch {
                fatalError()
            }
        } else {
            print("The local JSON file could not be found")
        }
    }
    
    //*****************************************************************
    // Get LastFM/iTunes Data
    //*****************************************************************
    
    class func getTrackDataWithSuccess(_ queryURL: String, success: @escaping ((_ metaData: Data?) -> Void)) {

        loadDataFromURL(URL(string: queryURL)!) { data, _ in
            // Return Data
            if let urlData = data {
                success(urlData)
            } else {
                if DEBUG_LOG { print("API TIMEOUT OR ERROR") }
            }
        }
    }
    
    //*****************************************************************
    // REUSABLE DATA/API CALL METHOD
    //*****************************************************************
    
    class func loadDataFromURL(_ url: URL, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess          = true
        sessionConfig.timeoutIntervalForRequest     = 15
        sessionConfig.timeoutIntervalForResource    = 30
        sessionConfig.httpMaximumConnectionsPerHost = 1
        
        let session = URLSession(configuration: sessionConfig)
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let responseError = error {
                completion(nil, responseError as NSError?)
                
                if DEBUG_LOG { print("API ERROR: \(error)") }
                
                // Stop activity Indicator
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"io.codemarket", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    
                    if DEBUG_LOG { print("API: HTTP status code has unexpected value") }
                    
                    completion(nil, statusError)
                    
                } else {
                    
                    // Success, return data
                    completion(data, nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}
