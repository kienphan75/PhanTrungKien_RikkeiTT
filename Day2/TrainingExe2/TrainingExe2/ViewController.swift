//
//  ViewController.swift
//  TrainingExe2
//
//  Created by Trung Kien on 7/3/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfLastNameKana: UITextField!
    @IBOutlet weak var tfFirstNameKana: UITextField!
    @IBOutlet weak var btnMs: CheckBox!
    @IBOutlet weak var btnMr: CheckBox!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfDateOfBith: UITextField!
   
    
    
    @IBAction func actionClickMr(_ sender: Any) {
        if btnMr.isChecked{
            
        }
        else{
            btnMs.isChecked = false
        }
    }
    @IBAction func actionClickMs(_ sender: Any) {
        if btnMs.isChecked{
            
        }
        else{
            btnMr.isChecked = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func actionSubmit(_ sender: Any) {
        if let email = tfEmail.text, let firstName = tfFirstName.text, let lastName = tfLastName.text, let phone = tfPhone.text, let firstNameKana = tfFirstNameKana.text, let lastNameKana = tfLastNameKana.text {
            if email != "" && firstName != "" && lastName != "" && phone != "" && firstNameKana != "" && lastNameKana != "" {
                    if btnMs.isChecked || btnMr.isChecked{
                    let alertControler = UIAlertController(title: "Thông báo", message: "Đăng kí thành công", preferredStyle: .alert)
                    alertControler.addAction(UIAlertAction(title: "Oke", style: .default, handler: nil))
      
                    
                    present(alertControler, animated: true, completion: nil)
                }
                    else{
                        let alertControler = UIAlertController(title: "Thông báo", message: "Chưa nhập đủ đầu vào", preferredStyle: .alert)
                        alertControler.addAction(UIAlertAction(title: "Oke", style: .default, handler: nil))
                        present(alertControler, animated: true, completion: nil)
                }
                
            }
            
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfEmail{
            if let email = tfEmail.text{
                if !email.isValidEmail(){
                    let alertControler = UIAlertController(title: "Thông báo", message: "Email định dạng sai", preferredStyle: .alert)
                    alertControler.addAction(UIAlertAction(title: "Oke", style: .default, handler: nil))
                    present(alertControler, animated: true, completion: nil)
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("start1")
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfDateOfBith{
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            tfDateOfBith.inputView = datePickerView
            
            datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone{
            guard let text = textField.text else { return true }
            let newLeght =  text.characters.count + string.characters.count - range.length
            return newLeght <= 11
        }
        return false
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tfDateOfBith.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    
    

}

