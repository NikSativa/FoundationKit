# FoundationKit
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FFoundationKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/NikSativa/FoundationKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FFoundationKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/NikSativa/FoundationKit)

FoundationKit is a collection of extensions and utilities for Foundation framework.

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
