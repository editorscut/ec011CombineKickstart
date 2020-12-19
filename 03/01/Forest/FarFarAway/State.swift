import Foundation

public class State: NSObject {
  private var model = Model() {
    willSet { willChangeValue(for: \.value) }
    didSet  { didChangeValue(for: \.value)  }
  }
  
  @objc dynamic public var value: Int {
    model.value
  }
}

extension State {
  public func next() {
    model = model.next
  }
}
