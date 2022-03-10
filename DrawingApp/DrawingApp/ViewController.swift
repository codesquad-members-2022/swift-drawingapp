import UIKit
import OSLog

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var plane: Plane = Plane()
    //TODO: Rectangle을 딕셔너리에 넣어주기 위해 Hashable을 달아줘야함
    var viewDictionary: [Rectangle : UIView] = [:]
    var selectedView: UIView?
    //TODO: [사각형] 버튼위에 사각형이 생성되면 클릭이 안됨
    @IBAction func rectangleButtonTouched(_ sender: Any) {
        //버튼을 누르면 실행될 메서드 (1,2)
        self.plane.addRectangle()
    }
    
//    탭되었을 때 실행할 메서드
    //TODO: 사각형이 겹쳐있을 떄 더 상단에 있는 사각형을 선택해야함 기준이 앞에 있는 것을 택하는 지, 뒤에 있는 것을 택하는지 확실치 않음, 뒤에 있는 것을 택하는 것같음
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let viewPoint: CGPoint = sender.location(in: self.view)
        // 뷰포인트를 넘기면, rectangle.point 로 변환하는 작업은 model에서 처리해야하지 않나 싶네요. 그러나 저게 CGPoint 타입이여서, 그것을 viewController에서 해줌
        let rectPoint: Rectangle.Point = Rectangle.Point(x: viewPoint.x, y: viewPoint.y)
        plane.TouchedRectangle(at: rectPoint)
    }
    
//    배경 뷰가 터치되도록 기능을 추가하는 메서드
    func shouldBackgroundViewBeTouched() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
//    뷰 생명 주기 중 첫번째
    override func viewDidLoad() {
        super.viewDidLoad()
        // 플레인의 대행 처리는 뷰컨트롤러가 맡겠다.
        plane.addedRectangleDelegate = self
        plane.touchedRectangleDelegate = self
        
        shouldBackgroundViewBeTouched()
    }
}

//MARK: 우아하게 프로토콜을 확장하는 방법
extension ViewController: RectangleAddedDelegate {
    func didMakeRectangle(rectangle: Rectangle) {
        let rectView = UIView(frame: CGRect(x: rectangle.getPoint().x, y: rectangle.getPoint().y, width: rectangle.getSize().width, height: rectangle.getSize().height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
        self.viewDictionary[rectangle] = rectView
        self.view.addSubview(rectView)
    }
}

extension ViewController: RectangleTouchedDelegate {
    func TouchedRectangle(rectangle: Rectangle) {
        if let view = self.selectedView {
            view.layer.borderWidth = .zero
        }
        let touchedView = self.viewDictionary[rectangle]
        touchedView?.layer.borderWidth = 3.0
        touchedView?.layer.borderColor = UIColor.blue.cgColor
        self.selectedView = touchedView
    }
}
