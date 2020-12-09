import UIKit

class ViewController: UIViewController {
  @IBOutlet private weak var label: UILabel!
  
  @IBAction private func next(_ sender: UIButton) {
    label.text = Int.random(in: 1...100).description
  }
}

