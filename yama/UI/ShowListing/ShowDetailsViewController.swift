//
//  ShowDetailsViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ShowDetailsViewController: UIViewController {
    static let identifier = "showDetailsViewControllerId"

    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let minHeight: CGFloat = 57
    let maxHeight: CGFloat = 273
    
    let minWidth: CGFloat = 38
    let maxWidth: CGFloat = 182
    
    fileprivate var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePoster()
        configureBackground()
    
        descriptionLabel.text = show.overview
        scrollView.delegate = self
    }
    
    private func configurePoster() {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w342\(show.posterPath ?? show.backdrop)") else { return }
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: show.title + "posterPath")
        let time = Constants.imageFadeoutTime
        let processor = RoundCornerImageProcessor(cornerRadius: Constants.imageCornerRadius)
        let options: KingfisherOptionsInfo = [.transition(.fade(time)),
                                              .processor(processor)]

        posterImageView.kf.setImage(with: resource, placeholder: nil, options: options)
        
    }
    
    private func configureBackground() {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w342\(show.posterPath ?? show.backdrop)") else { return }
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: show.title + "posterPath")
        let time = Constants.imageFadeoutTime
        let processor = RoundCornerImageProcessor(cornerRadius: Constants.imageCornerRadius)
        let options: KingfisherOptionsInfo = [.transition(.fade(time)),
                                              .processor(processor)]
        
        posterImageView.kf.setImage(with: resource, placeholder: nil, options: options)
    }
    
    
    class func create(for show: Show) -> ShowDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ShowDetailsViewController.identifier) as! ShowDetailsViewController
        vc.show = show
        return vc
    }
}

extension ShowDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        posterHeight.constant -= offset

        if posterHeight.constant < minHeight {
            posterHeight.constant = minHeight
        }

        if posterHeight.constant > maxHeight {
            posterHeight.constant = maxHeight
        }

        self.view.layoutIfNeeded()
    }
}
