//
//  Validator.swift
//  Validator
//
//  Created by lazymisu on 11/05/23.
//

import Foundation

public protocol Validation {
    var errorKey: String { get }
    var errorMessage: String { get }
    func validate(_ field: String) -> Bool
}

public class ValidationResult: NSObject {
    public let isValid: Bool
    public let error: ValidationError?
    
    public init(isValid: Bool, error: ValidationError?) {
        self.isValid = isValid
        self.error = error
    }
}

public class ValidationError: NSObject {
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
    
    public func add(_ validation: Validation, errorMessage: String? = nil) {
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
