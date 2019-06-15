//
//  ViewController.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var languagePicker: UIPickerView!
    
    private var selectedLanguage = LanguageType.english
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePicker.dataSource = self
        languagePicker.delegate = self
        languagePicker.selectedRow(inComponent: 0)
        setLanguage()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let number = numberTextField.text
        else {
            return
        }
        
        Network.signUp(firstName: firstName, lastName: lastName, number: number, language: selectedLanguage.rawValue) { success in
            guard success == true else { return }
            
            self.performSegue(withIdentifier: "codeVerification", sender: nil)
        }
    }
    
    func setLanguage() {
        language.text = selectedLanguage.title
    }
}

extension SignUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageType.allCases.count
    }
}

extension SignUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let language = LanguageType.allCases[row]
        return language.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = LanguageType.allCases[row]
        setLanguage()
    }
}
