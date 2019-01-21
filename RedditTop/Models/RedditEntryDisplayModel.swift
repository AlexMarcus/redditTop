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
}
