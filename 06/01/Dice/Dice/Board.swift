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
    die.sharedRoll
      .print("\t 1")
      .map(DieView.init)
      .handleEvents(receiveCompletion: {[weak self] _ in
                      self?.stop()})
      .assign(to: &$dieView)
    
    cancellable =
      die.sharedRoll
      .print("\t 2")
      .sink{_ in}
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
