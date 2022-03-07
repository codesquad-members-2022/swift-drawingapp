import UIKit
import OSLog

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet private weak var tappableView: UIView! {
        didSet {
            tappableView.backgroundColor = .red
        }
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        tappableView.addGestureRecognizer(tapGestureRecognizer)
    }
}
