import SwiftUI

struct TallyView {
  let tallies: [Int]
}

extension TallyView: View {
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
