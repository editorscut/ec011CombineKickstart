import Foundation
import UIKit

let formatter: NumberFormatter = {
  let f = NumberFormatter()
  f.numberStyle = .spellOut
  return f
}()

extension Int {
  var spellOut: String {
    formatter.string(for: self) ?? ""
  }
}
