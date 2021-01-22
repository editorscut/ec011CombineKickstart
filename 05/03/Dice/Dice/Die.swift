import Combine
import Foundation

class Die {
  let roll = PassthroughSubject<Int, Never>()
  private var cancellable: AnyCancellable?
}

extension Die {
  func next() {
    roll.send(.random(in: 1...6))
  }
  
  func start() {
    cancellable =
      Timer
      .publish(every: 1,
               on: RunLoop.main,
               in: .common)
      .autoconnect()
      .sink {[weak self] _ in
        self?.next()
      }
  }
  
  func stop() {
    roll.send(completion: .finished)
  }
}
