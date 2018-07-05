//
//  TableViewCell.swift
//  TrainingExe4
//
//  Created by Trung Kien on 7/3/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var loviValue: UILabel!
    @IBOutlet weak var lbavValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
