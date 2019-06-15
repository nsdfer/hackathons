//
//  AddContactViewController.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languagePicker: UIPickerView!
    
    private var selectedLanguage = LanguageType.english
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePicker.dataSource = self
        languagePicker.delegate = self
        languagePicker.selectedRow(inComponent: 0)
        setLanguage()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let number = numberTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text
        else {
            return
        }
        
        let contact = User(firstName: firstName, lastName: lastName, number: number)
        contact.save()
        self.dismiss(animated: true, completion: nil)
//        
//        Network.getPhoneNumber(number: number, language: selectedLanguage) { number in
//            guard let number = number else { return }
//            
//            let contact = User(firstName: firstName, lastName: lastName, number: number, sendLanguage: self.selectedLanguage)
//            contact.save()
//            
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    func setLanguage() {
        languageLabel.text = selectedLanguage.title
    }
}

extension AddContactViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageType.allCases.count
    }
}

extension AddContactViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let language = LanguageType.allCases[row]
        return language.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = LanguageType.allCases[row]
        setLanguage()
    }
}
