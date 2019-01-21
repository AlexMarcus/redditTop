//
//  AppConstants.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/17/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation

func getApiLimitString(limit: Int) -> String{
    if(limit > 0){
        return "?limit=\(limit)"
    } else {
        return "?limit=25)"
    }
}

struct AppConstants {
    
    //Application URLS
    struct Urls {
        static let redditUrl = "https://reddit.com/top/.json"
    }
    
    //API Limit
    static let limit = 10
    
    
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
            static let preview = "preview"
            
            struct Preview {
                static let images = "images"
                
                struct Images {
                    static let source = "source"
                    
                    struct Source {
                        static let url = "url"
                        static let width = "width"
                        static let height = "height"
                    }
                }
            }
        }
        
        
    }

    static let redditCellReuseIdentifier = "redditCell"
    
}
