public class State: NSObject {
  private var model = Model() {
    willSet { willChangeValue(for: \.value) }
    didSet { didChangeValue(for: \.value) }
  }
}

extension State {
  @objc dynamic public var value: Int {
    model.value
  }
  
  public func next() {
    model = model.next
  }
}
