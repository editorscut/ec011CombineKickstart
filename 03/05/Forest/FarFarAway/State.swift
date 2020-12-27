import Combine

public class State {
  private var model = Model() {
    didSet {
      subject.send()
    }
  }
  public let subject = PassthroughSubject<Void, Never>()
  
  public init(){}
}

extension State {
  public var value: Int {
    model.value
  }
  
  public func next() {
    model = model.next
  }
}
