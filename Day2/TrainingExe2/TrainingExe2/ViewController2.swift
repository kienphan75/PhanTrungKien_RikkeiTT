//
//  ViewController2.swift
//  TrainingExe2
//
//  Created by Trung Kien on 7/3/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbFirstName: UILabel!
    @IBOutlet weak var lbLastName: UILabel!
    
    var peopele : Dictionary<String,String>?
    
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = peopele{
            lbFirstName.text = p["firstName"]
            lbLastName.text = p["lastName"]
            lbEmail.text = p["email"]
            lbPhone.text = p["phone"]
        }
       
    }

    

}
