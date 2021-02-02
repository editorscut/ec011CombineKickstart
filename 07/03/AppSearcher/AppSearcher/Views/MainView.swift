//
//  ContentView.swift
//  AppSearcher
//
//  Created by Daniel Steinberg on 1/31/21.
//

import SwiftUI

struct MainView {
  @StateObject private var request = Request()
  @State private var title = "Enter Search Term"
  @State private var searchTerm = ""
}

extension MainView: View {
  var body: some View {
    VStack {
      SearchTermEntry(searchTerm: $searchTerm,
                      action: commit,
                      actionTitle: "Search")
      Spacer()
    }
    .navigationTitle(title)
  }
}

extension MainView {
  private func commit() {
    request.search(for: searchTerm)
    title = searchTerm
    searchTerm.removeAll()
  }
}
