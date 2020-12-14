public struct Model {
  public let value: Int
  
  init() { value = 0 }
}

extension Model {
  private init(value: Int) {
    self.value = value
  }
  
  var next: Model {
    Model(value: Int.random(in: 1...100))
  }
}

