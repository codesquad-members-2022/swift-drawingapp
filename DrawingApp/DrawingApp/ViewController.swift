import UIKit
import OSLog

class ViewController: UIViewController {
    let factory: SquareFactory = SquareFactory()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var squareAry : [Square] = []
        
        for i in 1..<5 {
            squareAry.append(factory.createSquare(size: Size(width: Double(i * 100), height: Double(i * 200)), point: Point(X: Double(i * 300), Y: Double(i * 400)), R: UInt8(i + 10), G: UInt8(i + 20), B: UInt8(i + 30), alpha: 2 * i + 1))
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(squareAry[i])")
        }
    }
}
