import Combine

public class State {
  @Published private var model = Model()
  
  lazy public private(set) var valuePublisher: AnyPublisher<Int, Never>
    = $model
    .dropFirst(2)
    .map(\.value)
    .prefix(5)
    .eraseToAnyPublisher()
  
  public init() {}
}


extension State {
  public func next() {
    model = model.next
  }
}
