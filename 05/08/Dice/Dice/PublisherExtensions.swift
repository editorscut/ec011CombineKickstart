import Combine

extension Publisher {
  func onValue(perform f: @escaping (Self.Output) -> Void) -> Publishers.HandleEvents<Self> {
    self.handleEvents(receiveOutput: f)
  }
  
  func onFinished(perform f: @escaping (Subscribers.Completion<Self.Failure>) -> Void) -> Publishers.HandleEvents<Self> {
    self.handleEvents(receiveCompletion: {completion in
      if completion == .finished {return f(completion)}
    })
  }
}
