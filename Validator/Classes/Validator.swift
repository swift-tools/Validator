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
    func validate(_ field: String) -> Bool
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
            let isValid = validation.validate(field)
            if !isValid {
                let errorMessage = self.customErrorMessages[validation.errorKey] ?? validation.errorMessage
                let validationError = ValidationError(errorMessage: errorMessage, errorKey: validation.errorKey)
                return ValidationResult(isValid: isValid, error: validationError)
            }
        }
        return ValidationResult(isValid: true, error: nil)
    }
}

public struct RequiredValidation: Validation {
    public init() { }
    
    public var errorKey: String { "Required" }
    
    public var errorMessage: String { "This field is required." }
    
    public func validate(_ field: String) -> Bool {
        return !field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

public struct EmailValidation: Validation {
    public init() { }
    
    public var errorKey: String { "Email" }

    public var errorMessage: String { "Please enter a valid email address." }

    public func validate(_ field: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: field)
    }
}
