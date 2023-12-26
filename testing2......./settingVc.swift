//
//  settingVc.swift
//  testing2.......
//
//  Created by siddappa tambakad on 24/12/23.
//

import UIKit

class settingVc: UIViewController {
    
    
    @IBOutlet var userTextView: UITextView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var displayTypedText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTextView.delegate = self
        
        addButton.layer.cornerRadius = 15
        userTextView.layer.cornerRadius = 15
        
        //adding padding
        userTextView.textContainerInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        displayTypedText.text = userTextView.text
        
    }
    
   @objc func updateTextView(notification:Notification) {
       print("you clicked \(notification)")
        let userInfo = notification.userInfo!
        let keyBoardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyBoardEndFrame = self.view.convert(keyBoardSize, to: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            userTextView.contentInset = UIEdgeInsets.zero
        } else {
            userTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardEndFrame.height, right: 0)
            userTextView.scrollIndicatorInsets = userTextView.contentInset
        }
        userTextView.scrollRangeToVisible(userTextView.selectedRange)

    }
}

extension settingVc: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.userTextView.resignFirstResponder()
    }
}
