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
      .$model
      .dropFirst()
      .map(\.value)
      .assignDescription(asOptionalTo: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
