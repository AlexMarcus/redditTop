//
//  ViewController.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/17/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var redditCollectionView: UICollectionView!
    
    var redditEntries: [RedditEntryDisplayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reddit/Top"
        self.redditCollectionView.backgroundColor = .blue
        self.redditCollectionView.delegate = self
        self.redditCollectionView.dataSource = self

        for i in 0...30 {
            if i % 3 == 0 {
                redditEntries.append(RedditEntryDisplayModel(title: "short"))
            } else if i % 3 == 1 {
                redditEntries.append(RedditEntryDisplayModel(title: "meduim meduim meduim meduim meduim meduim meduim meduim"))
            } else {
                redditEntries.append(RedditEntryDisplayModel(title: "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long"))
            }
        }
        
    }


}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthOffset: CGFloat = 20 + 40 + 10 + 75
        
        let width = collectionView.bounds.width - widthOffset
        let size = CGSize(width: width, height: 1000)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let estimatedFrame = NSString(string: redditEntries[indexPath.item].title ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        
        
        return CGSize(width: collectionView.bounds.width - 20, height: estimatedFrame.height < 20 ? 100 : estimatedFrame.height + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return redditEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.redditCellReuseIdentifier, for: indexPath) as! RedditCollectionViewCell
        cell.setUpCell(displayModel: redditEntries[indexPath.item])
        
        return cell
    }
    
    
}

