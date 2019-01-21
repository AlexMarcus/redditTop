//
//  RedditApiClient.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/20/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation

class RedditApiClient {
    
    func loadPageOfData(after: String?, completionHandler: ((_ newAfter: String?, _ json: NSArray?)->())?){
        var urlString = AppConstants.Urls.redditUrl
        let limitString = getApiLimitString(limit: 150)
        urlString += limitString
        if let afterUnwrapped = after {
            urlString += "&after=\(afterUnwrapped)"
        }
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    if let completionHandler = completionHandler, let jsonData = responseJSON.object(forKey: AppConstants.RedditJsonDataKeys.data) as? NSDictionary {
                        let after = jsonData.object(forKey: AppConstants.RedditJsonDataKeys.after) as? String
                        let posts = jsonData.object(forKey: AppConstants.RedditJsonDataKeys.children) as? NSArray
                        completionHandler(after, posts)
                    }
                }
            }
            catch {
                print("Error fetching entries from the API: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
