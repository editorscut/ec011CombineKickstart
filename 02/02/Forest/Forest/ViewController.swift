import UIKit
import Combine
import FarFarAway

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellables: Set<AnyCancellable> = Set()
  private let model = Model()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    labelSubscription().store(in: &cancellables)
  }
  
  @IBAction private func next(_ sender: UIButton) {
    model.next()
  }
}

extension ViewController {
  private func labelSubscription() -> AnyCancellable {
    model.$value
      .dropFirst()
      .map(\.description)
      .sink{[weak self] string in
        self?.label.text = string
      }
  }
}
