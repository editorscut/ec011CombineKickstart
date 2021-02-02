import Combine
import Foundation

class Request: ObservableObject {
  @Published private var searchTerm = ""
  private var cancellables = Set<AnyCancellable>()
  
  func search(for searchTerm: String) {
    Just(searchTerm)
      .map(applyFormatting)
      .compactMap(iTunesURL)
      .sink {url in
        print(url.description)
      }
      .store(in: &cancellables)
  }
}

extension Request {
  private func applyFormatting(to rawTerm: String) -> String {
    rawTerm.replacingOccurrences(of: " ",
                                 with: "+")
  }
  
  private func iTunesURL(for formattedTerm: String) -> URL? {
    var components = iTunesURLBase
    components
      .queryItems?
      .append(URLQueryItem(name: "term",
                           value: formattedTerm))
    return components.url
  }
}
