//
//  ShowsListViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 02/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit

class ShowsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.getPopularShows(page: 1) { shows in
            shows.forEach {
                print($0.title)
                print($0.releaseDate)
            }
        }
    }
    
    

}

