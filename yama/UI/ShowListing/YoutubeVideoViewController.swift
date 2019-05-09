
//
//  VideoView.swift
//  yama
//
//  Created by Alejandro Ravasio on 09/05/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import YoutubePlayer_in_WKWebView

/// This is a simple class to contain embed a youtube video in.
/// It's pretty pointless, but I want to cover the functionality and later decide how it will integrate
/// taking into account UI/UX.
/// TODO: TODO: Give this a proper design and figure out how / where to integrate it.
class YoutubeVideoViewController: UIViewController {
    
    static let identifier = "YoutubeVideoViewControllerId"
    
    @IBOutlet weak var videoView: WKYTPlayerView!
    
    fileprivate var id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.load(withVideoId: id)
    }
    
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    class func create(with id: String) -> YoutubeVideoViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: YoutubeVideoViewController.identifier) as! YoutubeVideoViewController
        vc.id = id
        return vc
    }
}
