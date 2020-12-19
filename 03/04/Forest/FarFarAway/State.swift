import Combine

public class State {
  private var model = Model() {
    didSet {
      subject.send()
    }
  }
  public let subject = PassthroughSubject<Void, Never>()
  
  public var value: Int { model.value }
  
  public init() {}
}

extension State {
  public func next() {
    model = model.next
  }
}
