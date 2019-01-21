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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
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
        self.imageView.image = UIImage(imageLiteralResourceName: "reddit_placeholder")
    }
    
    func setUpCell(displayModel: RedditEntryDisplayModel?){
        if let displayModel = displayModel {
            self.backgroundColor = .white
            self.imageView.image = UIImage(imageLiteralResourceName: "reddit_placeholder")
            self.titleLabel.text = displayModel.title
            //imageViewHeight.constant = 0
        }
        
        
    }
}
