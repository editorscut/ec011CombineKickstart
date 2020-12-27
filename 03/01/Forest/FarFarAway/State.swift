public class State {
  @Published private var model = Model()
  @Published public private(set) var value = 0
  
  public init(){
    $model
      .map(\.value)
      .assign(to: &$value)
  }
}

extension State {
  public func next() {
    model = model.next
  }
}
