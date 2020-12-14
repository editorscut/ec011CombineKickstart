public class Model: NSObject {
  @objc dynamic public private(set) var value: Int = 0
}

extension Model {
  public func nextRandomValue() {
    value = Int.random(in: 1...100)
  }
}
