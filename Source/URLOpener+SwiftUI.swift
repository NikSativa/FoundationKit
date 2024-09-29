#if canImport(SwiftUI)
import Foundation
import SwiftUI

#if swift(>=6.0)
@MainActor
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
protocol URLOpening: Sendable {
    #if os(watchOS)
    func route(to url: URL)
    #else
    typealias Completion = (_ accepted: Bool) -> Void
    func route(to url: URL, completion: @escaping Completion)
    #endif
}

@MainActor
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
final class URLOpener: Sendable {
    private let openURLAction: OpenURLAction

    init() {
        self.openURLAction = .init { url in
            return .systemAction(url)
        }
    }
}
#else
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
protocol URLOpening {
    #if os(watchOS)
    func route(to url: URL)
    #else
    typealias Completion = (_ accepted: Bool) -> Void
    func route(to url: URL, completion: @escaping Completion)
    #endif
}

@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
final class URLOpener {
    private let openURLAction: OpenURLAction

    init() {
        self.openURLAction = .init { url in
            return .systemAction(url)
        }
    }
}
#endif

@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
extension URLOpener: URLOpening {
    #if os(watchOS)
    func route(to url: URL) {
        openURLAction.callAsFunction(url)
    }
    #else
    func route(to url: URL, completion: @escaping Completion) {
        openURLAction.callAsFunction(url, completion: completion)
    }
    #endif
}
#endif
