import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var isRunning = false
  private var cancellables = Set<AnyCancellable>()
}

extension Board {
  private func connect() {
    die = Die()
    dieViewPipeline()
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
  
  private func demoPipeline() -> AnyCancellable {
    die.sharedRoll
      .allSatisfy {int in int.isMultiple(of: 2)}
      .print("Demo ==>")
      .sink{bool in print("\t All Even:", bool)}
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
