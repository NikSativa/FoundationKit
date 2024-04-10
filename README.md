# FoundationKit

FoundationKit is a collection of extensions and utilities for Foundation framework.

### Defaults
Wrapper for UserDefaults that allows you to store and retrieve Codable objects.

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

### Expirable
Property wrapper that allows you to set expiration time for the value.

```swift
@Expirable(lifetime: .oneHour) var token: String?
```

### LinkDetector
Utility that allows you to detect links in a given string.

```swift
let detector = LinkDetector()
let links = detector.detectLinks(in: "Hello, check this link https://github.com")
print(links) // ["https://github.com"]
```

### NotificationDispatcher
Wrapper for NotificationCenter that allows you to observe and post notifications.
- `NotificationToken` is a token that is used to remove the observer when it is deallocated.

```swift
NotificationDispatcher.addObserver(forName: .didReceiveData) { notification in
    print("data received")
}.store(in: &tokens)
```
