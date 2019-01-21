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
    
    var selectedDisplayModel: RedditEntryDisplayModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reddit/Top"
        self.redditCollectionView.backgroundColor = AppConstants.Colors.mainColor
        self.view.backgroundColor = AppConstants.Colors.mainColor
        self.redditCollectionView.delegate = self
        self.redditCollectionView.dataSource = self
        
        
        viewModel.loadEntries(after: nil) {
            self.redditCollectionView.reloadData()
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = redditCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.SegueIds.collectionToImageView{
            let destination = segue.destination as? DetailsViewController
            destination?.displayModel = selectedDisplayModel
        }
    }

}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let currentDisplayModel = viewModel.redditPosts?[indexPath.item]
        
        var widthOffset: CGFloat = 60 //10 (leading imageview) + 10 (trailing imageview)+ 20 (trailing textview) + 20 (adjustment to width of cells) -- values of margins to get the expected height of the title label
        if currentDisplayModel?.hasThumbnail ?? false {
            widthOffset += 75
        }
        
        let width = collectionView.bounds.width - widthOffset
        let size = CGSize(width: width, height: 1000)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        let estimatedFrame = NSString(string: currentDisplayModel?.title ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        
        
        return CGSize(width: collectionView.bounds.width - 20, height: estimatedFrame.height < 20 ? 95 : estimatedFrame.height + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.redditPosts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.redditCellReuseIdentifier, for: indexPath) as! RedditCollectionViewCell
        cell.setUpCell(displayModel: viewModel.redditPosts?[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let display = viewModel.redditPosts?[indexPath.item]
        if display?.isImage ?? false{
            selectedDisplayModel = display
            self.performSegue(withIdentifier: AppConstants.SegueIds.collectionToImageView, sender: nil)
        }
    }
    
    
}

