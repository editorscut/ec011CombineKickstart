import SwiftUI

struct SearchTermEntry {
  @Binding var searchTerm: String
  let action: () -> Void
  let actionTitle: String
}

extension SearchTermEntry: View {
  var body: some View {
    HStack {
      TextField("Search Term",
                text: $searchTerm,
                onCommit: action)
        .multilineTextAlignment(.center)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)
      Button(actionTitle, action: action)
        .disabled(searchTerm.isEmpty)
        .padding(.horizontal)
    }
    .padding()
  }
}
