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
    state.valuePublisher
      .map(\.description)
      .sink{[weak self] completion in
        self?.buttonIsNotEnabled = true
        if case let .failure(error) = completion {
          self?.contents = "Error: \(error)"
        }
      } receiveValue: {[weak self] string in
        self?.contents = string
      }
  }
}

extension Link {
  func next() {
    state.next()
  }
}
