import Combine

class Board: ObservableObject {
  private let die = Die()
  @Published private(set) var dieView = DieView()
  
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
}
