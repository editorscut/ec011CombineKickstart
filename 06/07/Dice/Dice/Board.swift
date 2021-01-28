import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  private var greenDie = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var greenDieView = DieView.green()
  @Published private(set) var compareView = CompareView(values: (0,0))
  @Published private(set) var isRunning = false
}

extension Board {
  private func connect() {
    die = Die()
    greenDie = Die()
    dieViewPipeline()
    greenDieViewPipeline()
    compareViewPipeline()
  }
  
  private func dieViewPipeline() {
    die.sharedRoll
      .print("Die View")
      .map(DieView.init)
      .handleEvents(receiveOutput: {[weak self] _
                      in self?.greenDie.next()})
      .assign(to: &$dieView)
  }
  
  private func greenDieViewPipeline() {
    greenDie.sharedRoll
      .print("Green Die View")
      .map(DieView.green)
      .assign(to: &$greenDieView)
  }
  
  private func compareViewPipeline() {
    Publishers.Zip(die.sharedRoll,
                   greenDie.sharedRoll)
      .map(CompareView.init)
      .assign(to: &$compareView)
  }
}

extension Board {
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
