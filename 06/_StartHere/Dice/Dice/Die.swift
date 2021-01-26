import Combine
import Foundation

class Die {
  private(set) var sides = 6
  let roll = PassthroughSubject<Int, Never>()
  private var cancellable: AnyCancellable?
}

extension Die {
  func next() {
    roll.send(.random(in: 1...sides))
  }
  
  func start(every interval: TimeInterval = 1) {
    cancellable =
      Timer
      .publish(every: interval,
               on: RunLoop.main,
               in: .common)
      .autoconnect()
      .sink {[weak self] _ in
        self?.next()
      }
  }
  
  func stop() {
    roll.send(completion: .finished)
    cancellable?.cancel()
  }
}
