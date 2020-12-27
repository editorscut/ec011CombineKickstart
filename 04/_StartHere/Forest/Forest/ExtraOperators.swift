import Combine

extension Publisher where Output: CustomStringConvertible {
  func description() -> Publishers.Map<Self, String> {
    map(\.description)
  }
  func descriptionAsOptional() -> Publishers.Map<Self, String?> {
    map{.some($0.description)}
  }
}

extension Publisher where Output: CustomStringConvertible,
                          Failure == Never {
  func assignDescription(to published: inout Published<String>.Publisher) {
    description().assign(to: &published)
  }
  
  func assignDescription(asOptionalTo published: inout Published<String?>.Publisher) {
    descriptionAsOptional().assign(to: &published)
  }
}
