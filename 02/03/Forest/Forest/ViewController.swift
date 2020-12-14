import UIKit
import Combine
import FarFarAway

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellables: Set<AnyCancellable> = Set()
  private let state = State()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    labelSubscription().store(in: &cancellables)
  }
  
  @IBAction private func next(_ sender: UIButton) {
    state.next()
  }
}

extension ViewController {
  private func labelSubscription() -> AnyCancellable {
    state.$model
      .dropFirst()
      .map(\.value.description)
      .sink{[weak self] string in
        self?.label.text = string
      }
  }
}
