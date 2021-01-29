import Combine

public class State {
  @Published private var model = Model()
  
  lazy public private(set) var valuePublisher: AnyPublisher<Int, Error>
    = $model
    .dropFirst()
    .map(\.value)
    .print("Value")
    .tryMap(normalizedValue)
    .eraseToAnyPublisher()
  
  public init() {}
}


extension State {
  public func next() {
    model = model.next
  }
}

fileprivate  func normalizedValue(_ value: Int) throws -> Int {
  if value.isMultiple(of: 5) {
    throw DivisibleByFive(value)
  } else {
    return value % 3
  }
}
