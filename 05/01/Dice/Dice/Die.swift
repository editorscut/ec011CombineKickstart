import Combine

struct Die {
  let roll = PassthroughSubject<Int, Never>()
}

extension Die {
  func next() {
    roll.send(.random(in: 1...6))
  }
}
