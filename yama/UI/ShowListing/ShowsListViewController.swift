//
//  ShowsListViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

/// This VC displays a list of shows that are provided to it by the DataProvider
class ShowsListViewController: UIViewController {
    
    @IBOutlet weak var searchContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var popularShowsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    

    // Complete list of shows given by the DataProvider
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
    
    fileprivate var selectedFilter: FilterType = .byTitle
    
    // Computed variable defined by filtering the Shows array based on the searchField text.
    // If the title contains the text in the search field, it's a match.
    fileprivate var filteredPopularShows: [Show] {
        get {
            if let text = searchField.text?.lowercased(), !text.isEmpty {
                
                switch selectedFilter {
                case .byTitle:
                    // We just need to filter by lowercased title.
                    return popularShows.filter { $0.title.lowercased().contains(text) }
                    
                    
                case .byGenre:
                    
                    // First we get all the Genres whose lowercased name matches the one we're writing.
                    // We save the IDs of those genres.
                    let filteredGenres = GenresManager.shared.genres.compactMap { genre -> Int? in
                        if genre.name.lowercased().contains(text) {
                            return genre.id
                        } else {
                            return nil
                        }
                    }
                    
                    // Then we filter all popular shows whose genres partially contain the filtered Genre IDs we just got.
                    //
                    // This works because there are actually two versions of `contains`. One takes a closure in order to check each
                    // element against a predicate, and the other just compares an element directly.
                    // In this case, `$0.genre` is using the closure version, and `filteredGenres` is using the element version.
                    // And that is the reason you can pass a contains function into another contains function.
                    let filteredShows = popularShows.filter { $0.genres.contains(where: filteredGenres.contains) }
                    
                    return filteredShows
                }
            } else {
                return popularShows
            }
        }
    }
    
    
    // Which genre to fetch based on the tabBarIndex
    // This feels kinda hacky, and I don't really like inspecting the parentVC from the child.
    // TODO: TODO: Reconsider a new way of handling this. Ideally, taking pagination into account.
    var genreToFetch: ShowType {
        get {
            guard let index = self.tabBarController?.selectedIndex else {
                return .popular
            }
            
            switch index {
            case 0:
                return .popular
            case 1:
                return .topRated(page: 1)
            case 2:
                return .upcoming(page: 1)
            default:
                return .popular
            }
        }
    }
    
    
    /// VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        configureSearchBar()
        configurePopularShowsView()
        
        DataProvider.getGenres() { genres in
            GenresManager.shared.genres = genres
            DataProvider.getShows(for: self.genreToFetch) { shows in
                self.popularShows = shows
                self.popularShowsCollectionView.reloadData()
            }
        }
    }
    
    fileprivate func configureSearchBar() {
        searchContainerHeight.constant = 0
        searchField.placeholder = "show name"
        searchField.addTarget(self, action: #selector(searchFieldChanged), for: .editingChanged)
    }
    
    // Tracks when the segmented control changes value
    @IBAction func searchTypeChanged(_ sender: Any) {
        selectedFilter = searchSegmentedControl.selectedSegmentIndex == 0 ? .byTitle : .byGenre
        popularShowsCollectionView.reloadData()
    }
    
    
    @objc private func searchFieldChanged() {
        popularShowsCollectionView.reloadData()
    }
    
    
    @IBAction func didTapSearch(_ sender: Any) {
        searchContainerHeight.constant = searchContainerHeight.constant == 0 ? 60 : 0
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
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

enum FilterType {
    case byTitle
    case byGenre
}
