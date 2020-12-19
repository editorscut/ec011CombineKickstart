import Combine

public class State {
  @Published private var model = Model()
  
  lazy public private(set) var valuePublisher:
                                  AnyPublisher<Int, Never>
    = $model
    .dropFirst()
    .map(\.value)
    .flatMap {value in
      Just(value).tryMap(self.normalizedValue)
        .catch{error in Empty()}
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
  func normalizedValue(_ value: Int) throws -> Int {
    if value.isMultiple(of: 5) {
      throw DivisibleByFive(value)
    } else {
      return value % 3
    }
  }
}
