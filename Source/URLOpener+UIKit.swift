#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

#if swift(>=6.0)
@MainActor
public protocol UIURLOpening: Sendable {
    typealias CompletionHandler = @MainActor @Sendable (Bool) -> Void

    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completion: @escaping CompletionHandler)
    func open(_ url: URL,
              completion: @escaping CompletionHandler)
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any])
    func open(_ url: URL)
}

@MainActor
public final class UIURLOpener {
    private let app: UIApplication

    public init(app: UIApplication) {
        self.app = app
    }
}
#else
public protocol UIURLOpening {
    typealias CompletionHandler = (Bool) -> Void

    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completion: @escaping CompletionHandler)
    func open(_ url: URL,
              completion: @escaping CompletionHandler)
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any])
    func open(_ url: URL)
}

public final class UIURLOpener {
    private let app: UIApplication

    public init(app: UIApplication) {
        self.app = app
    }
}
#endif

extension UIURLOpener: UIURLOpening {
    private func open(url: URL,
                      options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
                      completion: CompletionHandler? = nil) {
        if app.canOpenURL(url) {
            app.open(url,
                     options: options,
                     completionHandler: completion)
        } else {
            completion?(false)
        }
    }

    public func open(_ url: URL,
                     options: [UIApplication.OpenExternalURLOptionsKey: Any],
                     completion: @escaping CompletionHandler) {
        open(url: url,
             options: options,
             completion: completion)
    }

    public func open(_ url: URL,
                     completion: @escaping CompletionHandler) {
        open(url: url,
             completion: completion)
    }

    public func open(_ url: URL,
                     options: [UIApplication.OpenExternalURLOptionsKey: Any]) {
        open(url: url,
             options: options)
    }

    public func open(_ url: URL) {
        open(url: url)
    }
}
#endif
