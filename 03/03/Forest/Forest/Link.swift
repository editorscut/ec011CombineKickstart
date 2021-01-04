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
    NotificationCenter.default
      .publisher(for: valueUpdate)
      .compactMap {notification in
        notification.object as? State
      }
      .map(\.value)
      .assignDescription(asOptionalTo: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
