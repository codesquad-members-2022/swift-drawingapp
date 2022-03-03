import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var logger: Logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let factory = RectangleFactory()
        for index in 0..<4{
            let rectangle = factory.createRenctangle()
            logger.debug("Rectangle\(index+1) : \(rectangle)")
        }
    }
}

