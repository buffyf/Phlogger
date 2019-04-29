//
//  CreateJournalViewController.swift
//  Phlogger
//
//  Created by Barbara Feinstein on 4/20/19.
//  Copyright © 2019 Barbara Feinstein. All rights reserved.
//

import UIKit
import RealmSwift

class CreateJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var aboveNavBarView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var date = Date()
    var imagePicker = UIImagePickerController()
    var images : [UIImage] = []
    var startWithCamera = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // #4cc1fc
        navBar.tintColor = .white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        aboveNavBarView.backgroundColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // #4cc1fc
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        imagePicker.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool){
        updateDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if startWithCamera {
            startWithCamera = false
            blackCameraTapped("")
        }
    }
    
    func updateDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        navBar.topItem?.title = formatter.string(from: date)
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let realm = try? Realm() {
            let entry = Entry()
            entry.text = journalTextView.text
            entry.date = date
            for image in images {
                let picture = Picture(image: image)
                entry.pictures.append(picture)
                picture.entry = entry
            }
            try? realm.write {
                realm.add(entry)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func setDateTapped(_ sender: Any) {
        journalTextView.isHidden = false
        datePicker.isHidden = true
        setDateButton.isHidden = true
        date = datePicker.date
        updateDate()
    }
    
    @IBAction func blackCalendarTapped(_ sender: Any) {
        journalTextView.isHidden = true
        datePicker.isHidden = false
        setDateButton.isHidden = false
        datePicker.date = date
        
    }
    @IBAction func blackCameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        //lecture 44 Adding Images
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage {
            images.append(chosenImage)
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
            imageView.image = chosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true){
                //animation
            }
            
        }
    }

}
