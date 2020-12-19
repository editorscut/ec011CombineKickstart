import Foundation

public let valueUpdate = Notification.Name("valueUpdate")

public class State {
  private var model = Model() {
    didSet {
      NotificationCenter.default
        .post(name: valueUpdate,
              object: self)
    }
  }
  
  public init() {}
  
  public var value: Int {
    model.value
  }
}

extension State {
  public func next() {
    model = model.next
  }
}
