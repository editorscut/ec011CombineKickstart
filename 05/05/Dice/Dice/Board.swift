import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var isRunning = false
  var cancellable: AnyCancellable?
}

extension Board {
  private func connect() {
    die = Die()
    cancellable =
      die.roll
      .breakpoint(receiveOutput: {output in
                    print(output)
                    return false})
      .prefix{int in int != 1 }
      .breakpoint(receiveCompletion: {completion in
                    print(completion)
                    return false})
      .map(DieView.init)
      .sink
      {[weak self] completion in
        if completion == .finished {self?.stop()}
      }
      receiveValue: {[weak self] dieView in
        self?.dieView = dieView
      }
  }
  
  func next() {
    die.next()
  }
  
  func start() {
    connect()
    die.start()
    isRunning = true
  }
  
  func stop() {
    die.stop()
    isRunning = false
  }
}
