//
//  RedditUIImageView.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/20/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import UIKit

class RedditUIImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String?, compressionRatio: CGFloat, placeholder: UIImage?){
        imageCache.totalCostLimit = 1024 * 1024 * 40 // 40MB
        
        
        if let urls = urlString, !urls.isEmpty {
            imageUrlString = urls
            let key = String(describing: compressionRatio) + urls
            image = placeholder
            
            if let imageFromCache = imageCache.object(forKey: key as NSString) {
                image = imageFromCache
                return
            }
            
            
            guard let url = URL(string: urls) else {return}
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("URLSession Error: \(String(describing: error?.localizedDescription ?? "Unknown Error"))")
                    return
                }
                
                DispatchQueue.main.async {
                    if let imageToChange = UIImage(data: data!) {
                        let resizedImage = imageToChange.resized(withPercentage: compressionRatio)
                        if self.imageUrlString == urls {
                            self.image = resizedImage
                        }
                        imageCache.setObject(resizedImage!, forKey: key as NSString, cost: (data?.count)!)
                    }
                }
            } ).resume()
        } else {
            image = placeholder
        }
    }

}
