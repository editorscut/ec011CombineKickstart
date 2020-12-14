import UIKit
import Combine
import FarFarAway

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  private var cancellable: AnyCancellable?
  
  @Published private var model = Model(value: 0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cancellable
      = $model
      .dropFirst()
      .map(\.value.description)
      .sink {[weak self] string in
        self?.label.text = string
      }
  }
  
  @IBAction private func next(_ sender: UIButton) {
    model = Model(value: Int.random(in: 1...100))
  }
}
