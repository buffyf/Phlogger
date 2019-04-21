//
//  CreateJournalViewController.swift
//  Phlogger
//
//  Created by Barbara Feinstein on 4/20/19.
//  Copyright © 2019 Barbara Feinstein. All rights reserved.
//

import UIKit

class CreateJournalViewController: UIViewController {

    @IBOutlet weak var aboveNavBarView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // #4cc1fc
        navBar.tintColor = .white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        aboveNavBarView.backgroundColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // #4cc1fc
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

    }
    
    @objc func KeyboardWillHide(notification: Notification){
        changeKeyboardHeight(notification: notification)
        
    }
    
    @objc func KeyboardWillShow(notification: Notification){
        changeKeyboardHeight(notification: notification)
        
    }
    
    func changeKeyboardHeight(notification:Notification){
        if let keyboardFrame =
            notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            let keyHeight = keyboardFrame.cgRectValue.height
            bottomConstraint.constant = keyHeight + 10
            
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
    }
    @IBAction func saveTapped(_ sender: Any) {
    }
    @IBAction func setDateTapped(_ sender: Any) {
    }
    @IBAction func blackCalendarTapped(_ sender: Any) {
    }
    @IBAction func blackCameraTapped(_ sender: Any) {
    }
    
    

}
