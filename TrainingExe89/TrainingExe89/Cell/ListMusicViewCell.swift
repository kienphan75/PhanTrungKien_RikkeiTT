//
//  ListMusicViewCell.swift
//  TrainingExe89
//
//  Created by Trung Kien on 7/4/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class ListMusicViewCell: UITableViewCell {
   
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbArtist: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imageThum: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
