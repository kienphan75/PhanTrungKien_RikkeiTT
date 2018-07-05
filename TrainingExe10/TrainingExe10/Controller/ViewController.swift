//
//  ViewController.swift
//  TrainingExe10
//
//  Created by Trung Kien on 7/5/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit
import KYDrawerController
import BmoViewPager


class ViewController: UIViewController {
    @IBOutlet weak var viewPageNavigationBar: BmoViewPagerNavigationBar!
    @IBOutlet weak var viewPage: BmoViewPager!
    var arrName = ["MusicVideo", "Movie", "Ebook", "Audiobook", "Podcast"]
    
    
    @IBAction func actionMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Media"
        viewPage.dataSource = self
        viewPage.isHidden = false
        viewPageNavigationBar.autoFocus = true
        viewPageNavigationBar.viewPager = viewPage
    
    }

}

extension ViewController : BmoViewPagerDataSource{
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return arrName.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        
        switch page {
        case 0:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                vc.typeMedia = TypeMeida.MusicVideo
                return vc
            }
            break
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                vc.typeMedia = TypeMeida.Movie
                return vc
            }
            break
        case 2:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                vc.typeMedia = TypeMeida.Ebook
                return vc
            }
            break
        case 3:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                vc.typeMedia = TypeMeida.Audiobook
                return vc
            }
            break
        case 4:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                vc.typeMedia = TypeMeida.Podcast
                return vc
            }
            break
        default:
            break
        }
        return UIViewController()
    }

    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        return CGSize(width: navigationBar.bounds.width / 5, height: navigationBar.bounds.height)
    }

    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return arrName[page]
    }

    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UnderLineView()
        view.strokeColor = UIColor("#E35858")
        return view

    }

    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedStringKey : Any]? {

        return [
            NSAttributedStringKey.foregroundColor : UIColor.darkGray,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
        ]
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedStringKey : Any]? {
        return [
            NSAttributedStringKey.foregroundColor : UIColor.red,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)
        ]

    }
    
}

