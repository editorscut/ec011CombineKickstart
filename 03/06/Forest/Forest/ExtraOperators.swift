import Combine

extension Publisher where Output: CustomStringConvertible {
  func description() -> Publishers.Map<Self, String> {
    map(\.description)
  }
  func uiDescription() -> Publishers.Map<Self, String?> {
    map{.some($0.description)}
  }
}

extension Publisher where Output: CustomStringConvertible,
                          Failure == Never {
  func display(using published: inout Published<String>.Publisher) {
    description().assign(to: &published)
  }
  func uiDisplay(using published: inout Published<String?>.Publisher) {
    uiDescription().assign(to: &published)
  }
}
