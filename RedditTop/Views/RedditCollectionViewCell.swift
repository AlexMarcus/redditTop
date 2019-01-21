//
//  RedditCollectionViewCell.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/17/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import Foundation
import UIKit

class RedditCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imageView: RedditUIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    var storedConstant: CGFloat?
    //height constraint of the image to we can "remove" it if there is none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        self.imageViewHeight.constant = storedConstant ?? 75
        self.imageView.image = UIImage(imageLiteralResourceName: "reddit_placeholder")
        
    }
    
    func setUpCell(displayModel: RedditEntryDisplayModel?){
        backgroundColor = .white
        if let displayModel = displayModel {
            
            if displayModel.hasThumbnail {

                self.imageView.loadImageUsingUrlString(urlString: displayModel.thumbnailUrl, compressionRatio: 1.0, placeholder: UIImage(imageLiteralResourceName: "reddit_placeholder"))
            } else {
                storedConstant = imageViewHeight.constant
                imageViewHeight.constant = 0
            }
            
            self.titleLabel.text = displayModel.title
            self.authorLabel.text = displayModel.author
            self.entryDateLabel.text = displayModel.createdTimeString
            self.commentsLabel.text = displayModel.numComments
        }
    }
}
