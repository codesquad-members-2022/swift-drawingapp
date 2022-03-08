import UIKit
import OSLog

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var plane: Plane = Plane()
    
//    탭되었을 때 실행할 메서드
    //TODO: 사각형이 겹쳐있을 떄 더 상단에 있는 사각형을 선택해야함, 느낌상 뒤에 있는 사각형을 선택하는 듯 함
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let viewPoint: CGPoint = sender.location(in: self.view)
        let rectPoint: Rectangle.Point = Rectangle.Point(x: viewPoint.x, y: viewPoint.y)
        print("지정된 포인트 \(rectPoint.x), \(rectPoint.y)")
        let selectedRectangle: Rectangle? = plane.TouchedRectangle(at: rectPoint)
        if selectedRectangle != nil {
            print("선택된 사각형의 상세 설명: \(String(describing: selectedRectangle?.description))")
        } else {
            print("선택된 사각형이 없습니다.")
        }
    }
    
//    배경 뷰가 터치되도록 기능을 추가하는 메서드
    func shouldBackgroundViewBeTouched() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
//    플레인에 사각형을 4개 추가하는 메서드 .. 버튼을 누르면 실행될 메서드 (1,2)
    func addRectangles() {
        for _ in 0..<4 {
            self.plane.addRectangle()
        }
    }
//    Plane에 있는 사각형을 바탕으로 UIView를 만들고 이를 self.view 의 subView 에 추가하는 메서드
    func showRectangleViews() {
        for index in 0..<plane.rectangleCount {
            let rectangle = plane[index]
            let rectView = UIView(frame: CGRect(x: rectangle.getPoint().x, y: rectangle.getPoint().y, width: rectangle.getSize().width, height: rectangle.getSize().height))
            rectView.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
            print(rectangle.description)
            self.view.addSubview(rectView)
        }
    }
    
//    뷰 생명 주기 중 첫번째
    override func viewDidLoad() {
        super.viewDidLoad()
        // 플레인의 대행 처리는 뷰컨트롤러가 맡겠다.
        plane.delegate = self
        addRectangles()
    }
}


extension ViewController: PlaneDelegate {
    func didMakeRectangle(rectangle: Rectangle) {
        let rectView = UIView(frame: CGRect(x: rectangle.getPoint().x, y: rectangle.getPoint().y, width: rectangle.getSize().width, height: rectangle.getSize().height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
        print(rectangle.description)
        self.view.addSubview(rectView)
    }
}
