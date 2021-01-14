import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  @Published private(set) var dieView = DieView()
  var cancellable: AnyCancellable?
  
  init() {
    die.roll.delay(for: 1, scheduler: RunLoop.main)
      .map(DieView.init)
      .assign(to: &$dieView)
    
    cancellable =
      die.roll
      .count()
      .sink{ int in
        print(int.description)
      }
  }
}

extension Board {
  func next() {
    die.next(100)
  }
}
