//
//  DetailViewController.swift
//  TrainingExe10
//
//  Created by Trung Kien on 7/5/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var lbTrackName: UILabel!
    
    @IBOutlet weak var lbArtistName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var media : Media?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let medi = media{
            image.image = media?.image
            lbTrackName.text = medi.trackName
            lbArtistName.text = medi.artistName
        }
        
    }


}
