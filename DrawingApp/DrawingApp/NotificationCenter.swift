import Foundation

// 노티는 행위에 가깝다.
extension Notification.Name {
    static let add = Notification.Name("A rectangle is made")
    static let select = Notification.Name("Select a rectangle")
    static let change = Notification.Name("Change some property")
}
// 키는 변수에 가깝다.
enum NotificationKey {
    case color
    case alpha
    case rectangle
}
