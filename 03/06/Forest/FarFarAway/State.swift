import Combine

public class State: ObservableObject {
  @Published private var model = Model()
  
  public init(){}
}

extension State {
  public var value: Int {
    model.value
  }
  
  public func next() {
    model = model.next
  }
}
