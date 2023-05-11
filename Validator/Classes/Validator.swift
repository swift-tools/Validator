//
//  Validator.swift
//  Validator
//
//  Created by Felix Chacaltana on 11/05/23.
//

import Foundation

public protocol Validation {
    var errorKey: String { get }
    var errorMessage: String { get }
    func validate(_ field: String) -> ValidationResult
}

public struct ValidationResult {
    public let isValid: Bool
    public let error: ValidationError?
    
    public init(isValid: Bool, error: ValidationError?) {
        self.isValid = isValid
        self.error = error
    }
}

public struct ValidationError {
    public let errorMessage: String
    public let errorKey: String
    
    public init(errorMessage: String, errorKey: String) {
        self.errorMessage = errorMessage
        self.errorKey = errorKey
    }
}

public final class Validator {
    private var validations: [Validation] = []
    private var customErrorMessages: [String: String] = [:]
    
    public init() { }
    
    public func addValidation(_ validation: Validation, errorMessage: String? = nil) {
        validations.append(validation)
        customErrorMessages[validation.errorKey] = errorMessage
    }
    
    public func validate(_ field: String) -> ValidationResult {
        for validation in validations {
            let result = validation.validate(field)
            if !result.isValid, let error = result.error {
                let errorMessage = self.customErrorMessages[error.errorKey] ?? error.errorMessage
                return ValidationResult(isValid: false, error: ValidationError(errorMessage: errorMessage, errorKey: error.errorKey))
            }
        }
        return ValidationResult(isValid: true, error: nil)
    }
}

public final class RequiredValidation: Validation {
    public var errorKey: String {
        return "Required"
    }
    
    public var errorMessage: String {
        return "This field is required."
    }
    
    public init() { }
    
    public func validate(_ field: String) -> ValidationResult {
        let isValid = !field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return ValidationResult(isValid: isValid, error: ValidationError(errorMessage: errorMessage, errorKey: errorKey))
    }
}

public final class EmailValidation: Validation {
    public var errorKey: String {
        return "Email"
    }
    
    public var errorMessage: String {
        return "Please enter a valid email address."
    }
    
    public init() { }
    
    public func validate(_ field: String) -> ValidationResult {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let isValid = NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: field)
        return ValidationResult(isValid: isValid, error: ValidationError(errorMessage: errorMessage, errorKey: errorKey))
    }
}
