//
//  EditUserInfoTableViewController.swift
//  bluebird
//
//  Created by macbook on 1/22/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class EditUserInfoTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var document: bluebirdDocument?
    var bluebird: bluebirdModel?
    private var isMale = true
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        
        document?.bluebird = bluebirdModel(userPhoto: photoImageView.image!.pngData()!,
                                            firstName: firstNameTextField.text ?? "",
                                            lastName: lastNameTextField.text ?? "",
                                            patronimicName: patronimicNameTextField.text ?? "",
                                            birthDay: birthDayTextField.text ?? "",
                                            birthMonth: birthMonthTextField.text ?? "",
                                            birthYear: birthYearTextField.text ?? "",
                                            notes: document?.bluebird?.notes ?? "",
                                            lastModified: Date(),
                                            isMale: isMale,
                                            mmpiStorage: document?.bluebird?.mmpiStorage ?? [],
                                            mmpiTestDates: document?.bluebird?.mmpiTestDates ?? [],
                                            tScoresStorage: document?.bluebird?.tScoresStorage ?? [],
                                            tsiStorage: document?.bluebird?.tsiStorage ?? [],
                                            tsiTestDates: document?.bluebird?.tsiTestDates ?? [],
                                            tsiScoresStorage: document?.bluebird?.tsiScoresStorage ?? [])
            
        // notification to updtate table view before dismiss
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadLabels"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            if let photoData = document?.bluebird?.userPhoto {
                photoImageView.image = UIImage(data: photoData)
            }
        }
    }
    
    @IBOutlet weak var firstNameTextField: RoundedTextField! {
        didSet {
            firstNameTextField.text = document?.bluebird?.firstName
            firstNameTextField.tag = 1
            firstNameTextField.becomeFirstResponder()
            firstNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var lastNameTextField: RoundedTextField! {
        didSet {
            lastNameTextField.text = document?.bluebird?.lastName
            lastNameTextField.tag = 2
            lastNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var patronimicNameTextField: RoundedTextField! {
        didSet {
            patronimicNameTextField.text = document?.bluebird?.patronimicName
            patronimicNameTextField.tag = 3
            patronimicNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var genderPicker: UISegmentedControl! {
        didSet {
            if let maleGender = document?.bluebird?.isMale {
                if maleGender {
                    genderPicker.selectedSegmentIndex = 0
                } else {
                    genderPicker.selectedSegmentIndex = 1
                }
            }
            genderPicker.tag = 4
        }
    }
    
    @IBOutlet weak var birthDayTextField: UITextField! {
        didSet {
            birthDayTextField.text = document?.bluebird?.birthDay
            birthDayTextField.tag = 3
            birthDayTextField.delegate = self
        }
    }
    
    @IBOutlet weak var birthMonthTextField: UITextField! {
        didSet {
            birthMonthTextField.text = document?.bluebird?.birthMonth
            birthMonthTextField.tag = 3
            birthMonthTextField.delegate = self
        }
    }
    
    @IBOutlet weak var birthYearTextField: UITextField! {
        didSet {
            birthYearTextField.text = document?.bluebird?.birthYear
            birthYearTextField.tag = 3
            birthYearTextField.delegate = self
        }
    }
    
    @IBAction func genderSelection(_ sender: UISegmentedControl) {
        if genderPicker.selectedSegmentIndex == 0 {
            isMale = true
        } else {
            isMale = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Navigation Bar Appearance
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.shadowImage = UIImage()
        
        isMale = document?.bluebird?.isMale ?? true
        print(isMale)
    }
    
    // MARK: - Image Picker data source
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let photoSourceRequestController = UIAlertController(title: "Выберите источник", message: "", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Камера", style: .default, handler: {
                (action) in
                
                // you need to modify privacy reason in Info.plist to be able to request media data NSPhotoLibraryUsageDescription and NSCameraUsageDescription
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) { // checking if media type is available as user may restrict access
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Фото библиотека", style: .default, handler: {
                (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { // checking if media type is available as user may restrict access
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                           popoverController.sourceView = self.view //to set the source of your alert
                           popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                           popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                       }
            
            present(photoSourceRequestController, animated: true, completion: nil)
            
        }
    }
}
