public class State {
  @Published public private(set) var model = Model()
  
  public init(){}
}

extension State {
  public func next() {
    model = model.next
  }
}
