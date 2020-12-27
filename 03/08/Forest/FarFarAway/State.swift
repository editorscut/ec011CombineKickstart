import Combine

public class State {
  @Published private var model = Model()
  
  lazy public private(set) var valuePublisher: AnyPublisher<Int, Never>
  = $model
    .dropFirst()
    .map(\.value)
    .eraseToAnyPublisher()
  
  public init(){}
}

extension State {
  public func next() {
    model = model.next
  }
}
