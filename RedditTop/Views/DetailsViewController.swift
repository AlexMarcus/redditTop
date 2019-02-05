//
//  DetailsViewController.swift
//  RedditTop
//
//  Created by Alex Marcus on 1/20/19.
//  Copyright © 2019 Alex Marcus. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsImageView: RedditUIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var displayModel: RedditEntryDisplayModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        scrollView.backgroundColor = .black
        detailsImageView.backgroundColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "HEY", style: .plain, target: nil, action: nil)
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 20.0
        scrollView.minimumZoomScale = 1.0
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImageToCameraRoll))
        
        navigationItem.rightBarButtonItems = [saveButton]
        
    }
    
    override func viewDidLayoutSubviews() {
    detailsImageView.loadImageUsingUrlString(urlString: displayModel?.fullUrl, compressionRatio: 1.0, placeholder: UIImage(imageLiteralResourceName: "reddit_placeholder"))
        
    }
    
    @objc func saveImageToCameraRoll(){
        if let image = detailsImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(displaySaveMessage), nil)
        }
    }

    @objc func displaySaveMessage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer){
        if let error = error {
            let alert = UIAlertController(title: "Save Error", message: "Error Message: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "Saved to Photos!", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension DetailsViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailsImageView
    }
}
