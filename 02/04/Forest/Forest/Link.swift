import FarFarAway
import Combine

class Link {
  private let state = State()
  private var cancellables: Set<AnyCancellable> = Set()
  @Published private(set) var contents: String? = "..."
  
  init() {
    contentsSubscription().store(in: &cancellables)
  }
}

extension Link {
  func contentsSubscription() -> AnyCancellable {
    state.$model
      .dropFirst()
      .map(\.value.description)
      .sink {[weak self] string in
        self?.contents = string
      }
  }
}

extension Link {
  func next() {
    state.next()
  }
}
