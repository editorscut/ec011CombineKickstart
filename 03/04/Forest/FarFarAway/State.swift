import Combine

public class State {
  private var model = Model() {
    didSet {
      subject.send(model.value)
    }
  }
  public let subject = PassthroughSubject<Int, Never>()
  
  public init(){}
}

extension State {
  public func next() {
    model = model.next
  }
}
