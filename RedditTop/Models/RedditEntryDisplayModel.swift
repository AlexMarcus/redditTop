//
//  RedditEntryDisplayModel.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/17/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation

class RedditEntryDisplayModel{
    var title: String?
    var author: String?
    var createdTimeString: String?
    var numComments: String?
    var isImage: Bool = false
    var hasThumbnail: Bool = false
    var thumbnailUrl: String?
    var fullUrl: String?
    
    init(title: String, author: String, createdTimeString: String?, numComments: String?, isImage: Bool, hasThumbnail: Bool, thumbnailUrl: String?, fullUrl: String?) {
        self.title = title
        self.author = author
        self.createdTimeString = createdTimeString
        self.numComments = numComments
        self.isImage = isImage
        self.hasThumbnail = hasThumbnail
        self.thumbnailUrl = thumbnailUrl
        self.fullUrl = fullUrl
    }
    
    static func parseJsonRedditPost(json: NSDictionary) -> RedditEntryDisplayModel? {
        if let kind = json.object(forKey: AppConstants.RedditJsonDataKeys.kind) as? String, kind == AppConstants.RedditJsonDataKeys.t3 {
            
            if let data = json.object(forKey: AppConstants.RedditJsonDataKeys.data) as? NSDictionary {
                let title = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.title) as? String
                let author = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.author) as? String
                let createdTimeInSeconds = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.createdDate) as? Double
                let numComments = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.numComments) as? Int
                let thumbnail = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.thumbnail) as? String
                let fullUrl = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.url) as? String
                let postHint = data.object(forKey: AppConstants.RedditJsonDataKeys.Entries.postHint) as? String
                
                var createdDateString: String = ""
                var numCommentsString: String = ""
                var isImage = false
                var hasThumbnail = false
                var thumbnailUrlString = ""
                var fullUrlString = ""
                
                if let secondsSince1970 = createdTimeInSeconds{
                    let createdDate = Date(timeIntervalSince1970: secondsSince1970)
                    let currentDate = Date()
                    let differenceString = currentDate.offsetFrom(date: createdDate)
                    createdDateString = "\(differenceString) ago"
                }
                
                if let numComments = numComments {
                    if numComments >= 0 {
                        numCommentsString = "\(numComments) Comments"
                    }
                }
                
                if let thumbnail = thumbnail, thumbnail != "self", thumbnail != "default" {
                    hasThumbnail = true
                    thumbnailUrlString = thumbnail
                }
                
                if let postHint = postHint, let fullUrl = fullUrl {
                    if postHint == "image" {
                        isImage = true
                        fullUrlString = fullUrl
                    }
                }
                
                return RedditEntryDisplayModel(title: title ?? "TITLE ERROR", author: author ?? "AUTHOR ERROR", createdTimeString: createdDateString, numComments: numCommentsString, isImage: isImage, hasThumbnail: hasThumbnail, thumbnailUrl: thumbnailUrlString, fullUrl: fullUrlString)
            }
        }
        return nil
    }
}
