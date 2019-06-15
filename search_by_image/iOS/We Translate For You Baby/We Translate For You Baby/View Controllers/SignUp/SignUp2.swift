//
//  SignIn2.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import UIKit

class CodeVerification: UIViewController {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var sendCodeButton: UIButton!
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let codeString = codeTextField.text,
            let code = Double(codeString),
            let myself = Myself.current
        else {
            return
        }
        
        Network.sendCode(userId: myself.id, code: code) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
