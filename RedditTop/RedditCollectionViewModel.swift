//
//  RedditCollectionViewModel.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/20/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation

class RedditCollectionViewModel {
    
    let apiClient: RedditApiClient = RedditApiClient()
    
    var currentAfter: String?
    var redditPosts: [RedditEntryDisplayModel]?
    
    var hasAfter: Bool = false
    
    func loadEntries(after: String?, completionHandler:(()->())?){
        
        apiClient.loadPageOfData(after: after) {(newAfter, json) in
            if let json = json {
                var postsToAdd: [RedditEntryDisplayModel] = []
                for post in json {
                    if let post = post as? NSDictionary {
                        let redditEntry = self.parseJsonRedditPost(json: post)
                        postsToAdd.append(redditEntry)
                    }
                }
                if self.hasAfter {
                    self.redditPosts?.append(contentsOf: postsToAdd)
                    
                } else {
                    self.redditPosts = postsToAdd
                }
                if let after = newAfter {
                    self.currentAfter = after
                    self.hasAfter = true
                } else {
                    self.hasAfter = false
                }
            }
            if let completionHandler = completionHandler {
                DispatchQueue.main.async {
                    completionHandler()
                }
            }
        }
    }
    
    func parseJsonRedditPost(json: NSDictionary) -> RedditEntryDisplayModel {
        if let kind = json.object(forKey: AppConstants.RedditJsonDataKeys.kind) as? String, kind == AppConstants.RedditJsonDataKeys.t3 {
            
            if let data = json.object(forKey: AppConstants.RedditJsonDataKeys.data) as? NSDictionary {
                let title = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.title) as? String
                return RedditEntryDisplayModel(title: title ?? "ERROR: NO TITLE")
            }
        }
        
        //let title = json.object(forKey: AppConstants.RedditJsonDataKeys.Entries.title) as String
        return RedditEntryDisplayModel(title: "HELLO")
    }
    
}

