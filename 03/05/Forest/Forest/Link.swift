import FarFarAway

class Link {
  private let state = State()
  @Published private(set) var contents: String? = "..."
  
  init() {
    contentsSubscription()
  }
}

extension Link {
  func contentsSubscription() {
    state.objectWillChange
      .receive(on: RunLoop.main)
      .map{[state] _ in state.value}
      .uiDisplay(using: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
