//
//  ShowDetailsViewController.swift
//  yama
//
//  Created by Alejandro Ravasio on 03/02/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit

class ShowDetailsViewController: UIViewController {
    
    let longtext = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam malesuada augue pretium ex molestie rutrum. Proin non fringilla libero. Ut sollicitudin, ligula vitae vestibulum lacinia, justo enim tincidunt quam, eget fringilla est dolor sed lorem. Donec commodo facilisis elit, vel molestie purus. Suspendisse nunc magna, accumsan ut urna id, rhoncus sodales massa. Nulla sagittis lacinia elit. Nam ultrices convallis odio, sit amet facilisis velit laoreet sollicitudin. Nulla facilisi. Aliquam non sapien eget neque molestie efficitur. Suspendisse iaculis vel orci eu ornare. Ut egestas nunc id mi semper maximus. Nulla ligula eros, dictum ut consectetur a, condimentum eget urna. Nullam enim dui, dapibus lobortis sapien nec, mattis condimentum eros. Fusce at lacinia ipsum. Aenean aliquet ipsum id sem eleifend, ut malesuada neque viverra. Integer non orci sit amet magna faucibus posuere eget eget metus. Suspendisse potenti. In ipsum ligula, tempus vel libero eu, tincidunt condimentum turpis. Morbi luctus odio eu purus commodo porta. Curabitur id augue bibendum, vestibulum ante a, condimentum orci. Proin tellus nisi, hendrerit sit amet massa eget, elementum tempus metus. Etiam erat diam, volutpat sed arcu ac, ultricies mattis nisi. Cras nec elementum dolor.Duis ligula lorem, mollis consectetur dictum nec, suscipit ac augue. Aenean non nunc commodo, consectetur dolor ut, vulputate neque. Curabitur lobortis lacinia nisi vel porttitor. Sed laoreet vulputate libero, id posuere nisl facilisis quis. Nulla nibh nibh, mattis tincidunt pretium eget, dapibus id eros. Curabitur rhoncus nulla ligula, eu ornare metus dictum ultricies. Maecenas felis sem, finibus nec luctus ut, suscipit eu metus. Morbi luctus dapibus leo ut aliquam. Duis ut sagittis tortor. Sed non lacus in sem placerat ullamcorper.Vivamus mauris leo, vulputate et rhoncus non, eleifend feugiat mi. Nunc eu ullamcorper nunc. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas elit nisi, blandit ut pellentesque eu, vestibulum ut enim. Cras vel sem nibh. Mauris laoreet massa urna, a commodo mi rutrum vel. Mauris ut ex vitae est feugiat congue. Proin volutpat rhoncus sem, at bibendum justo tempus nec. Nulla et sapien eget orci dictum pellentesque non nec erat.Cras tincidunt pellentesque ligula, eget laoreet justo aliquet vel. Donec sit amet velit elementum, blandit arcu id, volutpat velit. Ut condimentum vitae ligula in hendrerit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque id velit scelerisque, dapibus massa non, euismod ex. Etiam massa est, sollicitudin ut mollis quis, cursus sagittis velit. Quisque bibendum quam non dolor iaculis maximus. Praesent neque massa, scelerisque a eros ut, euismod facilisis ante. Nulla nibh erat, facilisis eget ante ut, ornare gravida enim. Etiam non dolor quis lorem accumsan pulvinar nec porttitor erat. Sed malesuada diam risus, at luctus quam imperdiet nec. Proin diam eros, interdum sed ultricies a, pellentesque nec felis. Morbi quis tempus orci, vel luctus dui. Nulla luctus odio vitae sem ultrices sollicitudin. Donec eleifend, velit at eleifend lobortis, quam ante posuere sem, quis molestie magna orci a mauris. MAURICIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
    
    
    @IBOutlet weak var blackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label1: UILabel!
    
    let minHeight: CGFloat = 57
    let maxHeight: CGFloat = 273
    
    let minWidth: CGFloat = 38
    let maxWidth: CGFloat = 182
    
    private var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = longtext

        scrollView.delegate = self
    }
    
}


extension ShowDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        blackHeight.constant -= offset

        if blackHeight.constant < minHeight {
            blackHeight.constant = minHeight
        }

        if blackHeight.constant > maxHeight {
            blackHeight.constant = maxHeight
        }

        self.view.layoutIfNeeded()
    }
}
