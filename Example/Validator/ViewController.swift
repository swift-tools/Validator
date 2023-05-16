//
//  ViewController.swift
//  Validator
//
//  Created by lazymisu on 05/11/2023.
//  Copyright (c) 2023 lazymisu. All rights reserved.
//

import UIKit
import Validator

class ViewController: UIViewController, LiveValidatedTextFieldDelegate {
    @IBOutlet private weak var textField: LiveValidatedTextField!
    @IBOutlet private weak var lblErrorMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.validator.add(ValidationRule.Required())
        textField.validator.add(ValidationRule.Email())
    }
    
    @IBAction private func validate(_ sender: UIButton) {
        let result = textField.validate()
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
