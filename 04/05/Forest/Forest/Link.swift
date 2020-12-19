import FarFarAway
import Combine

class Link: ObservableObject {
  private let state = State()
  @Published private(set) var contents: String = "..."
  @Published private(set) var buttonIsNotEnabled = false
  private var cancellables: Set<AnyCancellable> = Set()
  
  init() {
    contentsSubscription().store(in: &cancellables)
  }
}

extension Link {
  func contentsSubscription() -> AnyCancellable {
    Fail(outputType: Int.self,
         failure: DivisibleByFive(15))
      .map(\.description)
      .print()
      .sink{[weak self] completion in
        switch completion {
        case .finished:
          self?.buttonIsNotEnabled = true
        case .failure(let error):
          self?.contents = "Error: \(error)"
        }
      }
      receiveValue: {[weak self] string in
        self?.contents = string
      }
  }
}

extension Link {
  func next() {
    state.next()
  }
}
