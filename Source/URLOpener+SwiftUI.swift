#if canImport(SwiftUI)
import Foundation
import SwiftUI

#if swift(>=6.0)
@MainActor
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
public protocol URLOpening: Sendable {
    #if os(watchOS)
    func route(to url: URL)
    #else
    typealias Completion = (_ accepted: Bool) -> Void
    func route(to url: URL, completion: @escaping Completion)
    #endif
}

@MainActor
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
public struct URLOpener: Sendable {
    private let openURLAction: OpenURLAction

    public init() {
        self.openURLAction = .init { url in
            return .systemAction(url)
        }
    }

    public init(openURLAction: OpenURLAction) {
        self.openURLAction = openURLAction
    }
}
#else
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
public protocol URLOpening {
    #if os(watchOS)
    func route(to url: URL)
    #else
    typealias Completion = (_ accepted: Bool) -> Void
    func route(to url: URL, completion: @escaping Completion)
    #endif
}

@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
public struct URLOpener {
    private let openURLAction: OpenURLAction

    public init() {
        self.openURLAction = .init { url in
            return .systemAction(url)
        }
    }

    public init(openURLAction: OpenURLAction) {
        self.openURLAction = openURLAction
    }
}
#endif

@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
extension URLOpener: URLOpening {
    #if os(watchOS)
    public func route(to url: URL) {
        openURLAction.callAsFunction(url)
    }
    #else
    public func route(to url: URL, completion: @escaping Completion) {
        openURLAction.callAsFunction(url, completion: completion)
    }
    #endif
}
#endif

#if !os(watchOS)
@available(iOS 15.0, tvOS 15.0, macOS 12.0, macCatalyst 15.0, watchOS 8.0, *)
public extension URLOpening {
    func route(to url: URL) {
        route(to: url, completion: { _ in })
    }
}
#endif
