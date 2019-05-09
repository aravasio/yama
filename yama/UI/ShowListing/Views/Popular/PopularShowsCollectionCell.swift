//
//  PopularShowsCollectionCell.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

/// This ViewCell is used for the show listing.
class PopularShowsCollectionCell: UICollectionViewCell {
    
    static let identifier = "PopularShowsCollectionCell"
    static let cellHeight: CGFloat = 156
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var blueFilterView: UIView!
    
    var show: Show!
    
    // In traditional MVVM fashion, we use a `configure` function to pass the view all the data
    // it needs to configure UI aspects.
    func configure(for show: Show) {
        self.show = show
        self.backgroundColor = .backgroundBlack
        
        /// Honestly, I don't quite get the type of post-processing the comp is applying to the image.
        /// It feels like it's turning it to B&W and then applies a slight blue hue to it, but I'm not 100% sure how it's being applied.
        /// Also there _might_ be a gradient, but I can't really tell from the samples in the comp how it is being computed (i.e. in which direction).
        /// My approximation is to fetch the image from the remote, then apply a B&W post processing and add a filter layer (not unlike sunglasses work) with an iceBlue-ish tint.
        blueFilterView.backgroundColor = UIColor.filterBlue
        
        titleLabel.text = show.title
        
        configureImageView()
        configureGenreLabel()
    }
    
    private func configureImageView() {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300\(show.backdrop)") else { return }
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: show.title + "backdropPath")
        let time = Constants.imageFadeoutTime
        
        let processor = RoundCornerImageProcessor(cornerRadius: Constants.imageCornerRadius) >>
                        BlackWhiteProcessor()

        let options: KingfisherOptionsInfo = [.transition(.fade(time)),
                                              .processor(processor)]
                       
                       
        imageView.kf.setImage(with: resource, placeholder: nil, options: options)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }
    
    private func configureGenreLabel() {
        /// We try to fetch a genre with localized text for the show, if not available, we just hide the genre label.
        if let id = show.genres.first, let genreName = GenresManager.shared.getGenre(for: id)?.name {
            categoryLabel.text = genreName
            categoryLabel.layer.cornerRadius = Constants.labelCornerRadius
            categoryLabel.layer.masksToBounds = true
            
        } else {
            categoryLabel.isHidden = true
        }
    }
    
    
}
