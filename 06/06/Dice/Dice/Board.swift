import Combine
import Foundation

class Board: ObservableObject {
  private var die = Die()
  private var greenDie = Die()
  @Published private(set) var dieView = DieView()
  @Published private(set) var greenDieView = DieView.green()
  @Published private(set) var dieViews = [DieView]()
  @Published private(set) var greenDieViews = [DieView]()
  @Published private(set) var mergedDieViews = [DieView]()
  @Published private(set) var combinedViews = [(DieView, DieView)]()
  @Published private(set) var isRunning = false
  @Published private(set) var tallies = Array(repeating: 0,
                                              count: 6)
  private var cancellables = Set<AnyCancellable>()
}

extension Board {
  private func connect() {
    die = Die()
    greenDie = Die()
    dieViewPipeline()
    greenDieViewPipeline()
    historyViewsPipelines()
    mergedViewsPipeline()
    combinedViewsPipeline()
  }
  
  private func dieViewPipeline() {
    die.sharedRoll
      .print("Die View")
      .map(DieView.init)
      .handleEvents(receiveCompletion: {[weak self] _ in
                      self?.stop()})
      .assign(to: &$dieView)
  }
  
  private func greenDieViewPipeline() {
    greenDie.sharedRoll
      .print("Green Die View")
      .map(DieView.green)
      .assign(to: &$greenDieView)
  }
  
  private func historyViewsPipelines() {
    $dieView
      .dropFirst()
      .scan([DieView]()){(dieViewArray, nextView) in
        dieViewArray + [nextView]
      }
      .assign(to: &$dieViews)
    
    $greenDieView
      .dropFirst()
      .scan([DieView]()){(dieViewArray, nextView) in
        dieViewArray + [nextView]
      }
      .assign(to: &$greenDieViews)
  }
  
  private func mergedViewsPipeline() {
    Publishers.Merge($dieView.dropFirst(),
                     $greenDieView.dropFirst())
      .scan([DieView]()){(dieViewArray, nextView) in
        dieViewArray + [nextView]
      }
      .assign(to: &$mergedDieViews)
  }
  
  private func combinedViewsPipeline() {
    Publishers.CombineLatest($dieView.dropFirst(),
                             $greenDieView.dropFirst())
      .scan([(DieView, DieView)]()){(dieViewArray, nextView) in
        dieViewArray + [nextView]
      }
      .assign(to: &$combinedViews)
  }
}

extension Board {
  func next() {
    die.next()
  }
  
  func start() {
    connect()
    die.start()
    greenDie.start(every: 0.37)
    isRunning = true
  }
  
  func stop() {
    die.stop()
    greenDie.stop()
    isRunning = false
  }
}
