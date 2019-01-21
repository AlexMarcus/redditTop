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
    let viewModel: RedditCollectionViewModel = RedditCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reddit/Top"
        self.redditCollectionView.backgroundColor = .blue
        self.redditCollectionView.delegate = self
        self.redditCollectionView.dataSource = self
        
        
        viewModel.loadEntries(after: nil) {
            self.redditCollectionView.reloadData()
        }
    

//        for i in 0...30 {
//            if i % 3 == 0 {
//                redditEntries.append(RedditEntryDisplayModel(title: "short"))
//            } else if i % 3 == 1 {
//                redditEntries.append(RedditEntryDisplayModel(title: "meduim meduim meduim meduim meduim meduim meduim meduim"))
//            } else {
//                redditEntries.append(RedditEntryDisplayModel(title: "long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long longg long long long long long long long long long long long long long long long long long long long long long long long long long long long long long longg long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long longg long long long long long long long long long long long long long long long long long long long long long long long long long long long long long longg long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long longg long long long long g"))
//            }
//        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = redditCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
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
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        let estimatedFrame = NSString(string: viewModel.redditPosts?[indexPath.item].title ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        
        
        return CGSize(width: collectionView.bounds.width - 20, height: estimatedFrame.height < 20 ? 80 : estimatedFrame.height + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.redditPosts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.redditCellReuseIdentifier, for: indexPath) as! RedditCollectionViewCell
        cell.setUpCell(displayModel: viewModel.redditPosts?[indexPath.item])
        
        return cell
    }
    
    
}

