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
    state.$model
      .dropFirst()
      .map(\.value.description)
      .map{string in .some(string)}
      .assign(to: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
