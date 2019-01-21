//
//  AppConstants.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/17/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation
import UIKit

func getApiLimitString(limit: Int) -> String{
    if(limit > 0){
        return "?limit=\(limit)"
    } else {
        return "?limit=25"
    }
}

struct AppConstants {
    

    //Colors
    struct Colors {
        static let mainColor = UIColor(red: 251/255.0, green: 113/255.0, blue: 36/255.0, alpha: 1.0)
        static let secondaryColor = UIColor(red: 255/255.0, green: 169/255.0, blue: 121/255.0, alpha: 1.0)
    }
    
    //Application URLS
    struct Urls {
        static let redditUrl = "https://reddit.com/top/.json"
    }
    
    //API Limit
    static let limit = 15
    
    
    //JSON Parsing
    struct RedditJsonDataKeys {
        static let data = "data"
        static let kind = "kind"
        static let t3 = "t3"
        static let children = "children"
        static let after = "after"
        
        struct Entries {
            static let title = "title"
            static let author = "author"
            static let numComments = "num_comments"
            static let createdDate = "created_utc"
            static let preview = "preview"
            static let thumbnail = "thumbnail"
            static let url = "url"
            static let postHint = "post_hint"
        }
    }
    
    struct SegueIds {
        static let collectionToImageView = "collection_to_image_view"
    }

    static let redditCellReuseIdentifier = "redditCell"
    
    
    
}
