import Combine

struct Die {
  let subject = PassthroughSubject<Int, Never>()
  lazy var roll = subject.share()
}

extension Die {
  func next(_ count: Int = 1) {
    for _ in 1...count {
    subject.send(.random(in: 1...6))
    }
    subject.send(completion: .finished)
  }
}
