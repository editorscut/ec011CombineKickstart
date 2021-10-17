import FarFarAway

class Link: ObservableObject {
  private let state = State()
  @Published private(set) var contents: String = "..."
  
  init() {
    contentsSubscription()
  }
}


extension Link {
  func contentsSubscription() {
    state
      .$value
      .dropFirst()
      .assignDescription(to: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
