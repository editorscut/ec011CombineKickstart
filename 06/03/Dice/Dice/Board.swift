import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var dieViews
    = [DieView(), DieView(), DieView(), DieView(), DieView()]
  @Published private(set) var isRunning = false
  private var cancellables = Set<AnyCancellable>()
}

extension Board {
  private func connect() {
    die = Die()
    dieViewPipeline()
    previousFivePipeline()
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
  
  private func previousFivePipeline() {
    die.sharedRoll
      .collect(5)
      .map{intArray in intArray.map(DieView.init)}
      .assign(to: &$dieViews)
  }
  
  private func demoPipeline() -> AnyCancellable {
    die.sharedRoll
      .collect(.byTimeOrCount(RunLoop.main, .seconds(2), 3))
      .print("Demo ==>")
      .sink{intArray in print("\t Collect:", intArray)}
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
