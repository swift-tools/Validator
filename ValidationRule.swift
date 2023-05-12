//
//  ValidationRule.swift
//  Validator
//
//  Created by Felix Chacaltana on 11/05/23.
//

import Foundation

public struct ValidationRule {
    
    public struct Regex: Validation {
        private let regex: String
        
        public var errorKey: String { "Regex" }
        
        public var errorMessage: String { "" }
        
        public init(_ regex: String) {
            self.regex = regex
        }
        
        public func validate(_ field: String) -> Bool {
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: field)
        }
    }
    
    public struct Required: Validation {
        public init() { }
        
        public var errorKey: String { "Required" }
        
        public var errorMessage: String { "This field is required." }
        
        public func validate(_ field: String) -> Bool {
            return !field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    public struct Email: Validation {
        public init() { }
        
        public var errorKey: String { "Email" }
        
        public var errorMessage: String { "Please enter a valid email address." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").validate(field)
        }
    }
    
    public struct PhonePE: Validation {
        public init() { }
        
        public var errorKey: String { "PhonePE" }
        
        public var errorMessage: String { "Please enter a valid phone." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^(\\+?51)?9[0-9]{8}$").validate(field)
        }
    }
    
    public struct Alpha: Validation {
        public init() { }
        
        public var errorKey: String { "Alpha" }
        
        public var errorMessage: String { "Only alphabetic characters are allowed." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^[a-zA-Z]+$").validate(field)
        }
    }
    
    public struct AlphaNum: Validation {
        public init() { }
        
        public var errorKey: String { "AlphaNum" }
        
        public var errorMessage: String { "Only alphanumeric characters are allowed." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("[a-zA-Z0-9]+$").validate(field)
        }
    }
    
    public struct NoSpecialChars: Validation {
        public init() { }
        
        public var errorKey: String { "NoSpecialChars" }
        
        public var errorMessage: String { "Special characters are not allowed." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^[a-zA-Z0-9]+$").validate(field)
        }
    }
    
    public struct LowerCase: Validation {
        public init() { }
        
        public var errorKey: String { "LowerCase" }
        
        public var errorMessage: String { "Only lowercase letters are allowed." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^[a-z]+$").validate(field)
        }
    }
    
    public struct UpperCase: Validation {
        public init() { }
        
        public var errorKey: String { "UpperCase" }
        
        public var errorMessage: String { "Only uppercase letters are allowed." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^[A-Z]+$").validate(field)
        }
    }
    
    public struct Numeric: Validation {
        public init() { }
        
        public var errorKey: String { "Numeric" }
        
        public var errorMessage: String { "The input must be a valid numeric value." }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^[0-9]+$").validate(field)
        }
    }
    
    public struct Length: Validation {
        public var min: Int
        
        public var max: Int
        
        public var errorKey: String { "Length" }
        
        public var errorMessage: String { "The input must be between \(min) and \(max) characters in length." }
        
        public init(min: Int, max: Int) {
            self.min = min
            self.max = max
        }
        
        public func validate(_ field: String) -> Bool {
            return Regex("^(?=.{\(min),\(max)}$).*$").validate(field)
        }
    }
}
