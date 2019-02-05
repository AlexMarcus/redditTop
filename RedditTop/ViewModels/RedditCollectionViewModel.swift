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
    
    var isLoading: Bool = false
    var shouldKeepPaginating: Bool = true
    
    func loadEntries(after: String?, completionHandler:(()->())?){
        isLoading = true
        apiClient.loadPageOfData(after: after) {(newAfter, json) in
            self.isLoading = false
            if let json = json {
                var postsToAdd: [RedditEntryDisplayModel] = []
                for post in json {
                    if let post = post as? NSDictionary {
                        if let redditEntry = RedditEntryDisplayModel.parseJsonRedditPost(json: post){
                            postsToAdd.append(redditEntry)
                        }
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
            } else {
                self.shouldKeepPaginating = false
            }
            if let completionHandler = completionHandler {
                DispatchQueue.main.async {
                    completionHandler()
                }
            }
        }
    }
    
    func reset(){
        hasAfter = false
        currentAfter = nil
        shouldKeepPaginating = true
        isLoading = false
    }
}

