import Foundation

@testable import FoundationKit

public extension NotificationToken {
    static func testMake() -> NotificationToken {
        final class HiddenObject: NSObject {}
        return NotificationToken(token: HiddenObject())
    }
}
