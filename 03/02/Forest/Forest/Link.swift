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
      .publisher(for: valueUpdate,
                 object: state)
      .compactMap{notification in
                  notification.object as? State}
      .map(\.value)
      .uiDisplay(using: &$contents)
  }
}

extension Link {
  func next() {
    state.next()
  }
}
