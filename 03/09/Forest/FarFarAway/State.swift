import Combine

public class State {
  @Published private var model = Model()
  @Published public private(set) var value = 0
  
  public init(){
    Task {await setUpValueSequence()}
  }
  
  @MainActor
  private func setUpValueSequence() async {
    let valueSequence
    = $model.values
      .dropFirst()
      .map(\.value)
    
    for await value in valueSequence {
      self.value = value
    }
  }
}

extension State {
  public func next() {
    model = model.next
  }
}
