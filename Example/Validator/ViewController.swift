//
//  ViewController.swift
//  Validator
//
//  Created by Felix Chacaltana on 05/11/2023.
//  Copyright (c) 2023 Felix Chacaltana. All rights reserved.
//

import UIKit
import Validator

class ViewController: UIViewController, LiveValidatedTextFieldDelegate {
    @IBOutlet private weak var txtRequired: ValidatedTextField!
    @IBOutlet private weak var txtEmail: LiveValidatedTextField!
    @IBOutlet private weak var lblErrorMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtRequired.validator.add(ValidationRule.Required())
        txtEmail.validator.add(ValidationRule.Email())
        txtEmail.liveValidatedDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func validate(_ sender: UIButton) {
        let result = txtRequired.validate()
        if let err = result.error {
            self.lblErrorMessage.text = "\(err.errorKey): \(err.errorMessage)"
        } else {
            self.lblErrorMessage.text = "OK"
        }
    }

    func validationSucceeded(for textField: UITextField) {
        self.lblErrorMessage.text = "OK"
    }
    
    func validationFailed(for textField: UITextField, withError error: ValidationError) {
        self.lblErrorMessage.text = "\(error.errorKey): \(error.errorMessage)"
    }
}
