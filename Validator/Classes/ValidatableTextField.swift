//
//  ValidatableTextField.swift
//  Validator
//
//  Created by lazymisu on 11/05/23.
//

import Foundation
import UIKit

public protocol ValidatableTextField {
    var validator: Validator { get }
    func validate() -> ValidationResult
}

public extension ValidatableTextField where Self: UITextField {
    func validate() -> ValidationResult {
        return validator.validate(text ?? "")
    }
}

open class ValidatedTextField: UITextField, ValidatableTextField {
    public var validator: Validator = Validator()
}

@objc public protocol LiveValidatedTextFieldDelegate: NSObjectProtocol {
    func validationSucceeded(for textField: UITextField)
    func validationFailed(for textField: UITextField, withError error: ValidationError)
}

open class LiveValidatedTextField: ValidatedTextField {
    private var debounceTimer: Timer?
    private var debounceInterval: TimeInterval = 1.0
    
    @IBOutlet weak open var liveValidatedDelegate: LiveValidatedTextFieldDelegate?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField() {
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.triggerValidation()
        }
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        debounceTimer?.invalidate()
        triggerValidation()
    }
    
    private func triggerValidation() {
        let result = validate()
        if let err = result.error {
            liveValidatedDelegate?.validationFailed(for: self, withError: err)
        } else {
            liveValidatedDelegate?.validationSucceeded(for: self)
        }
    }
}
