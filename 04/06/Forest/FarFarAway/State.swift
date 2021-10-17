import Combine

public class State {
  @Published private var model = Model()
  
  lazy public private(set) var valuePublisher: AnyPublisher<Int, DivisibleByFive>
    = $model
    .dropFirst()
    .map(\.value)
    .print("Value")
    .tryMap(normalizedValue)
    .mapError {error in
      error as! DivisibleByFive
    }
    .eraseToAnyPublisher()
  
  public init() {}
}


extension State {
  public func next() {
    model = model.next
  }
}

extension State {
  fileprivate  func normalizedValue(_ value: Int) throws -> Int {
    if value.isMultiple(of: 5) {
      throw DivisibleByFive()
    } else {
      return value % 3
    }
  }
}
