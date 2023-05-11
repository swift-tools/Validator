# Validator 🛡️

<!-- [![CI Status](https://img.shields.io/travis/lazymisu/Validator.svg?style=flat)](https://travis-ci.org/lazymisu/Validator)
[![Version](https://img.shields.io/cocoapods/v/Validator.svg?style=flat)](https://cocoapods.org/pods/Validator)
[![License](https://img.shields.io/cocoapods/l/Validator.svg?style=flat)](https://cocoapods.org/pods/Validator)
[![Platform](https://img.shields.io/cocoapods/p/Validator.svg?style=flat)](https://cocoapods.org/pods/Validator) -->

Validator is a Swift library that provides a simple yet flexible way to validate input fields using custom validation rules. It consists of a set of protocols and structs that define the validation rules and the validation results, and a main class that orchestrates the validation process.

## 🧪 Validations

Validator includes 🔟+ built-in validation rules and you can also create your own custom validation rules by implementing the `Validation` protocol.

Here's an example of how to create a custom validation rule:

```swift
struct MyValidationRule: Validation {
    var errorKey: String { "MyValidationRule" }
    var errorMessage: String { "This is not a valid input" }
    public func validate(_ field: String) -> ValidationResult {
        // validation logic here
    }
}

```

## 🚀 Usage

To use Validator in your Swift project, you need to add it as a dependency in your `Podfile`:

```ruby
target 'MyApp' do
  pod 'Validator'
end
```

Then you can import Validator in your Swift code and start using it:

```swift
import Validator

let validator = Validator()
validator.addValidation(LengthValidation(minLength: 3, maxLength: 10), errorMessage: "The field must be between 3 and 10 characters long")
validator.addValidation(RegexValidation(pattern: "[a-zA-Z0-9]+"), errorMessage: "The field must contain only alphanumeric characters")
let result = validator.validate("hello")
if result.isValid {
    print("The field is valid ✅")
} else {
    print("The field is invalid ❌: \(result.error?.errorMessage ?? "")")
}

```

Make sure to replace `MyApp` with the name of your target.

## 🎨 UIKit Integration

The Validator library also includes some implementations that make it easier to use Validator with UITextField objects. These implementations are designed to help you validate user input in real-time, as the user types.

There are three main classes you can use to achieve this:

- `ValidatableTextField`: This is a protocol that defines a basic set of requirements for a UITextField object to be considered validatable. If you adopt this protocol in your custom UITextField subclass, you'll get a default implementation of the `validate()` method that you can use to perform validation on the text entered by the user.

- `ValidatedTextField`: This is a concrete implementation of the ValidatableTextField protocol that you can use as a drop-in replacement for a standard UITextField. It comes with a default instance of the Validator class and the `validate()` method is already implemented, so you don't have to do anything else to start using it.

- `LiveValidatedTextField`: This is a more advanced implementation of the ValidatedTextField class that provides real-time feedback to the user as they type. It includes a delegate protocol, `LiveValidatedTextFieldDelegate`, that you can use to receive notifications whenever the validation state of the text field changes. You can customize the appearance of the text field based on its validation state, to provide more visual feedback to the user.

By using these classes, you can easily validate user input in your app and provide real-time feedback to the user, making your app more user-friendly and intuitive.

## Author

👨‍💻 Felix Chacaltana

📧 felix.chacaltana.felix@gmail.com

## License

📝 Validator is available under the MIT license. See the LICENSE file for more info.
