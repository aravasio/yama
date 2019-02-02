//
//  ShowsListViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit

class ShowsListViewController: UIViewController {

    fileprivate var mySubscriptions: [Show] = []
    fileprivate var popularShows: [Show] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.getPopularShows() { shows in
            shows.forEach {
                print($0.title)
                print($0.releaseDate)
            }
        }
    }
}
