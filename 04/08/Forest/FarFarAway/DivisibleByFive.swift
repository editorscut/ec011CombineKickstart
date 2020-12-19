extension String: Error {}

public struct DivisibleByFive: Error {
  private var value: Int
  public init(_ value: Int){
    self.value = value
  }
}
