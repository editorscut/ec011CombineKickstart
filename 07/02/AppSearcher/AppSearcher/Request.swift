import Combine
import Foundation

class Request: ObservableObject {
  private var cancellables = Set<AnyCancellable>()
  
  func search(for searchTerm: String) {
    Just(searchTerm)
      .map(applyFormatting)
      .compactMap(iTunesURL)
      .sink {[weak self] url in
        self?.request(for: url)
      }
      .store(in: &cancellables)
  }

  private func request(for url: URL) {
    URLSession.shared
      .dataTaskPublisher(for: url)
      .sink(receiveCompletion: {completion in
        switch completion {
        case .finished:
          print("Finished")
        case .failure(let error):
          print("Error:", error)
        }
      }, receiveValue: {(data, response) in
        print("Data:", data)
        print("Response:", response)
      })
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
