//
//  AddViewController.swift
//  TrainingExe5
//
//  Created by Trung Kien on 7/3/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    @IBOutlet weak var tfAvValue: UITextField!
    @IBOutlet weak var tfLoviValue: UITextField!
    
    @IBAction func actionSave(_ sender: Any) {
        if let avValue = tfAvValue.text , let loviValue = tfLoviValue.text{
            var appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.persistentContainer.viewContext
            var newAv = NSEntityDescription.insertNewObject(forEntityName: "AVResult", into: context)
            newAv.setValue(Float(avValue), forKey: "avValue")
            newAv.setValue(Int(loviValue), forKey: "loviValue")
            
            let date = Date()
            newAv.setValue(date, forKey: "captureDate")
            
            do {
                try context.save()
               navigationController?.popViewController(animated: true)
            } catch {
                print("Failed saving")
            }
            
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
