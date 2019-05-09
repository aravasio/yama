//
//  MovieDetailsViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


/// Movie Details VC. It's used to display more details on the received Movie.
class MovieDetailsViewController: UIViewController {
    
    static let identifier = "movieDetailsViewControllerId"

    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tintView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var originalLanguageTitleLabel: UILabel!
    
    
    let minHeight: CGFloat = 57
    let maxHeight: CGFloat = 273
    
    let minWidth: CGFloat = 38
    let maxWidth: CGFloat = 182
    
    fileprivate var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tintView.backgroundColor = .backgroundBlack
        
        trailerButton.isHidden = movie.videoPath?.isEmpty ?? true
        
        backButton.layer.cornerRadius = backButton.frame.width / 2
        backButton.backgroundColor = .backgroundBlack
        
        configureLabels()
        configurePoster()
        
        descriptionLabel.text = movie.overview
        scrollView.delegate = self
    }
    
    
    private func configureLabels() {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate
        originalLanguageLabel.text = movie.originalLanguage
        ratingLabel.text = "\(movie.rating) ⭐"
        
        
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.white,
            .strokeWidth : 3.0,
            ]
        
        overviewTitleLabel.attributedText = NSAttributedString(string: "Overview:", attributes: strokeTextAttributes)
        originalLanguageTitleLabel.attributedText = NSAttributedString(string: "Original language:", attributes: strokeTextAttributes)
    }
    
    
    //Fetch a poster or backdrop, get primary color from the image, apply noir filter.
    private func configurePoster() {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w342\(movie.posterPath ?? movie.backdrop)") else { return }

        self.posterImageView.isHidden = true
        ImageDownloader.default.downloadImage(with: imageUrl) { result in
            switch result {
            case .success(let value):
                value.image.getPredominantColors { colors in
                    self.posterImageView.isHidden = false
                    self.posterImageView.image = value.image
                    
                    // NOTE: .noir is a very expensive processing call. Sadly this means there's a small hiccup when the details load.
                    // This is because we have no choice but to process the image locally.
                    // Currently I just dipatch the image processing while I set the rest of the view, but this can arguably be poor UX.
                    DispatchQueue.global().async {
                        self.makeAndUseNoirImage(from: value.image)
                    }
                    self.tintView.backgroundColor = colors.primary
                    self.tintView.alpha = 0.6
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func makeAndUseNoirImage(from image: UIImage) {
        let noir = image.noir
        DispatchQueue.main.async {
            self.backgroundImageView.image = noir
            self.backgroundImageView.alpha = 0.6
        }
    }
    
    
    @IBAction func didTapWatchVide(_ sender: UIButton) {
        if let path = movie.videoPath {
            let vc = YoutubeVideoViewController.create(with: path)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func didTapBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     I use `create` as a mechanism for Dependency Injection. I send the function the required data for a valid VC,
     and it returns an instantiated VC that I only need to push forward.
     
     - Parameters:
         - movie: The Movie we want to present.
     
     - Returns: A MovieDetailsVC.
     */
    class func create(for movie: Movie) -> MovieDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: MovieDetailsViewController.identifier) as! MovieDetailsViewController
        vc.movie = movie
        return vc
    }
}

extension MovieDetailsViewController: UIScrollViewDelegate {

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
