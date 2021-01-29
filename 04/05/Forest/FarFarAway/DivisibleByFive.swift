public struct DivisibleByFive: Error {
  private let value: Int
  public init(_ value: Int){
    self.value = value
  }
}
