import UIKit
import Combine
import FarFarAway

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellables: Set<AnyCancellable> = Set()
  private var model = Model()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    valueForLabel().store(in: &cancellables)
  }
  
  @IBAction private func next(_ sender: UIButton) {
    model.nextRandomValue()
  }
}

extension ViewController {
  private func valueForLabel() -> AnyCancellable {
    model
      .publisher(for: \.value)
      .dropFirst()
      .map(\.description)
      .sink{[weak self] string in
        self?.label.text = string
      }
  }
}

