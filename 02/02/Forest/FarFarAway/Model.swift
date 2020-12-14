public class Model {
  @Published public private(set) var value: Int = 0
  
  public init(){}
}

extension Model {
  public func next() {
    value = Int.random(in: 1...100)
  }
}
