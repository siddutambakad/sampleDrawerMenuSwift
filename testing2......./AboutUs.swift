//
//  AboutUs.swift
//  testing2.......
//
//  Created by siddappa tambakad on 22/12/23.
//

import UIKit

class AboutUs: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var nameErrorField: UILabel!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var lastNameErrorField: UILabel!
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var phoneNumberErrorField: UILabel!
    @IBOutlet var checkBoxButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var emailErrorText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cornerRadius for submitButton
        submitButton.layer.cornerRadius = 10
        
        //adding images to the male button and female button
        maleButton.setImage(UIImage(named: "radio-off"), for: .normal)
        maleButton.setImage(UIImage(named: "radio-on"), for: .selected)
        
        femaleButton.setImage(UIImage(named: "radio-off"), for: .normal)
        femaleButton.setImage(UIImage(named: "radio-on"), for: .selected)
       
        //adding image for the checkbox
        checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        checkBoxButton.setImage(UIImage(named: "checked"), for: .selected)
        
        nameField.delegate = self
        lastNameField.delegate = self
        phoneNumberField.delegate = self
        emailField.delegate = self
        
        keyBoardDismiss()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func maleButtonPressed(_ sender: UIButton) {
        if sender == maleButton {
            maleButton.isSelected = true
            femaleButton.isSelected = false
        } else {
            maleButton.isSelected = false
            femaleButton.isSelected = true
        }
    }
    
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        if let name = nameField.text {
            if name.isEmpty {
                nameErrorField.text = "Name is Required"
            } else if !nameField.isValidName(name) {
                nameField.text = "Enter Valid Name"
            } else {
                nameField.text = ""
            }
        }
        
        if let lastName = lastNameField.text {
            if lastName.isEmpty {
                lastNameErrorField.text = "Last Name is Required"
            } else if !lastNameField.isValidName(lastName) {
                lastNameErrorField.text = "Enter Valid Last Name"
            } else {
                lastNameErrorField.text = ""
            }
        }
        
        if let phoneNumber = phoneNumberField.text {
            if phoneNumber.isEmpty {
                phoneNumberErrorField.text = "PhoneNumber is Required"
            } else if !phoneNumberField.isValidMobileNo(phoneNumber) {
                phoneNumberErrorField.text = "Enter Valid PhoneNumber"
            } else {
                phoneNumberErrorField.text = ""
            }
        }
        
        if let email = emailField.text {
            if email.isEmpty {
                emailErrorText.text = "Email is Required"
            } else if !nameField.isValidName(email) {
                emailErrorText.text = "Enter Valid Email"
            } else {
                emailErrorText.text = ""
            }
        }
    }
    
    
    
}

extension UITextField {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isValidMobileNo(_ mobileNo: String) -> Bool {
               let PHONE_REGEX = "^[6-9]\\d{9}$"
               let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
               let result = phoneTest.evaluate(with: mobileNo)
               return result
    }
    func isValidName(_ name: String) -> Bool {
        let regex = "^[a-zA-Z]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: name)
    }
    

   
}
extension UIViewController {
    // function for dismissing the keyboard
    func keyBoardDismiss() {
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapOutside)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AboutUs: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nameField {
            nameErrorField.text = ""
        } else if textField == lastNameField {
            lastNameErrorField.text = ""
        } else if textField == phoneNumberField {
            phoneNumberErrorField.text = ""
        } else if textField == emailField {
            emailErrorText.text = ""
        }
    }
}
