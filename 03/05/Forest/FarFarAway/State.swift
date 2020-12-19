import Combine

public class State: ObservableObject {
  @Published private var model = Model()
  
  public var value: Int { model.value }
  
  public init() {}
}

extension State {
  public func next() {
    model = model.next
  }
}
