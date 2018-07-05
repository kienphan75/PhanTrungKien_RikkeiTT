//
//  ViewController.swift
//  TrainingExe4
//
//  Created by Trung Kien on 7/3/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var btnRightItem: UIBarButtonItem!
    @IBOutlet weak var btnLeftItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var manageObjectContext: NSManagedObjectContext!
    var arrAV = [AVResultModel]()
    
    @IBAction func actionEdit(_ sender: Any) {
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.btnLeftItem.title = "Edit"
        }
        else
        {
            self.tableView.isEditing = true
            self.btnLeftItem.title = "Done"
        }
    }
    
    @IBAction func actionMove(_ sender: Any) {
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.btnRightItem.title = "Edit"
        }
        else
        {
            self.tableView.isEditing = true
            self.btnRightItem.title = "Done"
        }
        
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadDataFromDatabase()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAV.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        print(arrAV[indexPath.row].avValue)
        if let avValue = arrAV[indexPath.row].avValue, let loviValue = arrAV[indexPath.row].loviValue , let captureDate = arrAV[indexPath.row].captureDate {
            cell.lbavValue.text = "\(avValue)"
            cell.loviValue.text = "\(loviValue)"
            cell.lbCaptureDate.text = "\(captureDate)"
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.arrAV.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var itemToMove = arrAV[sourceIndexPath.row]
        arrAV.remove(at: sourceIndexPath.row)
        arrAV.insert(itemToMove, at: destinationIndexPath.row)
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            loadDataFromDatabase()
    }
    
    func loadDataFromDatabase(){
        var appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AVResult")
        request.returnsObjectsAsFaults = false
        do {
            arrAV.removeAll()
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var av = AVResultModel()
                av.avValue = data.value(forKey: "avValue") as! Float
                av.captureDate = data.value(forKey: "captureDate")  as! NSDate
                av.loviValue = data.value(forKey: "loviValue") as! Int
                
                arrAV.append(av)
            }
            tableView.reloadData()
            
        } catch {
            
            print("Failed")
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        if indexPath.row % 2 == 0{
            navigationController?.pushViewController(controller, animated: true)
        }
        else{
            present(controller, animated: true, completion: nil)
        }
    }

    



}

