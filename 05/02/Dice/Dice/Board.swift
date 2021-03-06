import Combine

class Board: ObservableObject {
  private var die = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var isRunning = false
  
  init() {
    die.roll
      .map(DieView.init)
      .assign(to: &$dieView)
  }
}

extension Board {
  func next() {
    die.next()
  }
  
  func start() {
    die.start()
    isRunning = true
  }
}
