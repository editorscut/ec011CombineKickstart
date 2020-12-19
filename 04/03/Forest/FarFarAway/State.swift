import Combine

public class State {
  @Published private var model = Model()
  
  lazy public private(set) var valuePublisher: AnyPublisher<Int, Never>
    = $model
    .print("Start (in State)")
    .dropFirst(2)
    .print("Dropped (in State)")
    .map(\.value)
    .print("Mapped (in State)")
    .prefix(5)
    .print("Prefixed (in State")
    .eraseToAnyPublisher()
  
  public init() {}
}

extension State {
  public func next() {
    model = model.next
  }
}
