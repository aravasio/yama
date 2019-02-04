//
//  ShowsListViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit

class ShowsListViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPopularShows()
        
        configurePopularShowsView()
    }
    
    private func fetchPopularShows() {
        API.getPopularShows() { shows in
            self.popularShows = shows
        }
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
        let show = popularShows[indexPath.row]
        let vc = ShowDetailsViewController.create(for: show)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularShowsCollectionView.dequeueReusableCell(withReuseIdentifier: PopularShowsCollectionCell.identifier, for: indexPath) as! PopularShowsCollectionCell
        let data = popularShows[indexPath.row]
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
