//
//  ShowsListViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit
import Kingfisher

class ShowsListViewController: UIViewController {
    
    @IBOutlet weak var searchFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var popularShowsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    fileprivate var mySubscriptions: [Show] = []
    
    fileprivate var popularShows: [Show] = [] {
        didSet {
            if popularShows.isEmpty {
                popularShowsCollectionView.isHidden = true
                activityIndicator.startAnimating()
                
            } else {
                popularShowsCollectionView.reloadData()
            }
            
        }
    }
    
    fileprivate var filteredPopularShows: [Show] {
        get {
            if let text = searchField.text?.lowercased(), !text.isEmpty {
                let results = popularShows.filter { $0.title.lowercased().contains(text) }
                return results
            } else {
                return popularShows
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        searchFieldHeight.constant = 0
        searchField.addTarget(self, action: #selector(searchFieldChanged), for: .editingChanged)
        
        configurePopularShowsView()
        
        API.getGenres() { genres in
            GenresManager.shared.genres = genres
            self.fetchPopularShows()
        }

    }
    
    private func fetchPopularShows() {
        API.getPopularShows() { shows in
            self.popularShows = shows
            self.popularShowsCollectionView.reloadData()
        }
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        searchFieldHeight.constant = 30
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func searchFieldChanged() {
        popularShowsCollectionView.reloadData()
    }
    
    private func configurePopularShowsView() {
        popularShowsCollectionView.delegate = self
        popularShowsCollectionView.dataSource = self
        popularShowsCollectionView.backgroundColor = .backgroundBlack
        
        let nib = UINib(nibName: PopularShowsCollectionCell.identifier, bundle: nil)
        popularShowsCollectionView.register(nib, forCellWithReuseIdentifier: PopularShowsCollectionCell.identifier)
    }
}


extension ShowsListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = filteredPopularShows[indexPath.row]
        let vc = ShowDetailsViewController.create(for: show)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPopularShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularShowsCollectionView.dequeueReusableCell(withReuseIdentifier: PopularShowsCollectionCell.identifier, for: indexPath) as! PopularShowsCollectionCell
        let data = filteredPopularShows[indexPath.row]
        cell.configure(for: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = PopularShowsCollectionCell.cellHeight
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
