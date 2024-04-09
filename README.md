# FoundationKit

FoundationKit is a collection of extensions and utilities for Foundation framework.

### example:
```swift
import FoundationKit
struct User: Codable {
    let name: String
    let email: String
    let age: Int
}

final class UserViewModel {
    @Defaults("user", defaultValue: nil)
    var user: User? {
        didSet {
            print("new user: \(user)")
        }
    }
}
```
