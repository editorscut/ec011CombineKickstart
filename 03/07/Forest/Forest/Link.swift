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
    state
      .valuePublisher
      .assignDescription(asOptionalTo: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
