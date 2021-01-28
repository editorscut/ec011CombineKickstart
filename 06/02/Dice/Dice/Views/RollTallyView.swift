import SwiftUI

struct RollTallyView {
  let tallies: [Int]
}

extension RollTallyView: View {
    var body: some View {
      List {
        ForEach(0..<6) {index in
          HStack {
            DieView(index + 1)
            Text(tallies[index].description)
          }
        }
        Text("Total: \(tallies.reduce(0,+))")
      }
    }
}
