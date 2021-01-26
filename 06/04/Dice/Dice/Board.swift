import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var dieViews
    = [DieView(), DieView(), DieView(), DieView(), DieView()]
  @Published private(set) var isRunning = false
  @Published private(set) var tallies = Array(repeating: 0, count: 6)
  private var cancellables = Set<AnyCancellable>()
}

extension Board {
  private func connect() {
    die = Die()
    dieViewPipeline()
    tallyPipeline()
    demoPipeline().store(in: &cancellables)
  }
  
  private func dieViewPipeline() {
    die.sharedRoll
      .print("Die View")
      .map(DieView.init)
      .handleEvents(receiveCompletion: {[weak self] _ in
                      self?.stop()})
      .assign(to: &$dieView)
  }
  
  private func tallyPipeline() {
    die.sharedRoll
      .scan(Array(repeating: 0, count: 6)) {(total, element) in
        var total = total
        total[element - 1] += 1
        return total
      }
      .assign(to:&$tallies)
  }
  
  private func demoPipeline() -> AnyCancellable {
    die.sharedRoll
      .map(\.spellOut)
      .print("Demo ==>")
      .scan(0){(total, element) in
        total + element.count
      }
      .sink {int in print("Sum of letters", int)}
  }
}

extension Board {
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
