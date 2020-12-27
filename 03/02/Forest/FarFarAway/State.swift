import Foundation

public class State: NSObject {
  private var model = Model() {
    didSet {value = model.value}
  }
  @objc dynamic public private(set) var value = 0
}

extension State {
  public func next() {
    model = model.next
  }
}
