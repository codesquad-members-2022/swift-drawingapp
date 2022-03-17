import UIKit
import OSLog

class ViewController: UIViewController{
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    private var plane: Plane = Plane()
    private var rectangleDictionary:[Id:UIView] = [:]
    private var temporarySelectedRectangleView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNotificationCenter()
        initializeAllUIViews()
        setGestureRecognizer()
        setPanGestureRecognizer()
    }

    private func initializeAllUIViews(){
        setCanvasView()
        setStylerView()
    }
    
    private func initializeNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(rectangleFoundFromPlane(_:)), name: Plane.NotificationName.rectangleFoundFromPlane, object: self.plane)
        NotificationCenter.default.addObserver(self, selector: #selector(rectangleNotFoundFromPlane), name: Plane.NotificationName.rectangleNotFoundFromPlane, object: self.plane)
        NotificationCenter.default.addObserver(self, selector: #selector(addingRectangleCompleted(_:)), name: Plane.NotificationName.rectangleAdded, object: self.plane)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedRecntalgeViewColor(_:)), name: Plane.NotificationName.rectangleColorUpdated , object: self.plane)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedRectangleViewAlpha(_:)), name: Plane.NotificationName.rectangleAlphaUpdated, object: self.plane)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedRectangleViewPoint(_:)), name: Plane.NotificationName.rectanglePointUpdated, object: self.plane)
    }
    
    private func setGestureRecognizer(){
        guard let canvasView = self.canvasView else { return }
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        canvasView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setPanGestureRecognizer(){
        guard let canvasView = self.canvasView else { return }
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_:)))
        canvasView.isUserInteractionEnabled = true
        canvasView.addGestureRecognizer(gestureRecognizer)
    }

    
    private func setCanvasView(){
        let frame = CGRect(x: self.view.frame.minX,
                           y: self.view.frame.minY,
                           width: self.view.frame.width*0.8,
                           height: self.view.frame.height)
        let canvasView = CanvasView(frame: frame,
                                    backGroundColor: .lightGray)
        canvasView.delegate = self
        self.canvasView = canvasView
        self.view.addSubview(canvasView)
    }
    
    private func setStylerView(){
        guard let canvasView = self.canvasView else { return }
        let frame = CGRect(x: canvasView.frame.width,
                           y: self.view.frame.minY,
                           width: self.view.frame.width - canvasView.frame.width,
                           height: self.view.frame.height)
        let stylerView = StylerView(frame: frame, backgroundColor: .white)
        stylerView.delegate = self
        self.stylerView = stylerView
        self.view.addSubview(stylerView)
    }
    
    @objc func addingRectangleCompleted(_ notification: Notification) {
        guard let rectangle = notification.userInfo?[Plane.UserInfoKey.rectangleAdded] as? RectangleApplicable else { return }
        guard let canvasView = self.canvasView else { return }
        
        if let rectangleView = createRectangleView(rectangle: rectangle){
            self.rectangleDictionary[rectangle.id] = rectangleView
            canvasView.insertSubview(rectangleView, belowSubview: canvasView.generatingButton)
        }
        
    }
    
    private func createRectangleView(rectangle: RectangleApplicable)-> UIView?{
        return RectangleViewFactory.createRectangleView(rectangle: rectangle)
    }
    
    @objc func rectangleFoundFromPlane(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.UserInfoKey.rectangleFound] as? RectangleApplicable else { return }
        self.updateViewWithSelectedRectangleModel(rectangle: rectangle)
    }
    
    private func updateViewWithSelectedRectangleModel(rectangle: RectangleApplicable){
        guard let canvasView = self.canvasView else { return }
        guard let rectangleView = self.rectangleDictionary[rectangle.id] else { return }
        
        if rectangle is RandomColorApplicable{
            self.updateColorRectangleInfo(rectangle: rectangle)
        }else{
            self.updateImageRectangleInfo(rectangle: rectangle)
        }
        canvasView.updateSelectedRectangleView(subView: rectangleView)
    }
    
    private func updateColorRectangleInfo(rectangle: RectangleApplicable){
        guard let stylerView = self.stylerView else { return }
        guard let rectangle = rectangle as? RectangleApplicable & RandomColorApplicable else { return }
        let r = rectangle.backgroundColor.r
        let g = rectangle.backgroundColor.g
        let b = rectangle.backgroundColor.b
        let opacity = rectangle.alpha.opacity.rawValue
        let hexString = "#\(String(Int(r*255), radix: 16))\(String(Int(g*255), radix: 16))\(String(Int(b*255), radix: 16))"
        stylerView.updateColorRectangleInfo(r: r, g: g, b: b, opacity: opacity, hexString: hexString)
    }
    
    private func updateImageRectangleInfo(rectangle: RectangleApplicable){
        guard let stylerView = self.stylerView else { return }
        stylerView.updateImageRectangleInfo(opacity: rectangle.alpha.opacity.rawValue)
    }
    
    @objc func rectangleNotFoundFromPlane(){
        guard let stylerView = self.stylerView else { return }
        guard let canvasView = self.canvasView else { return }
        stylerView.clearSelectedRectangleInfo()
        canvasView.clearRectangleViewSelection()
    }
    
    @objc func updateSelectedRecntalgeViewColor(_ notification: Notification){
        guard let newColor = notification.userInfo?[Plane.UserInfoKey.rectangleColorUpdated] as? Color else { return }
        guard let stylerView = self.stylerView else { return }
        guard let canvasView = self.canvasView else { return }
        
        let newUIColor = UIColor(red: newColor.r, green: newColor.g, blue: newColor.b, alpha: 1)
        let newHexString = "#\(String(Int(newColor.r*255), radix: 16))\(String(Int(newColor.g*255), radix: 16))\(String(Int(newColor.b*255), radix: 16))"
        stylerView.updateSelectedRectangleViewColorInfo(newColor: newUIColor, newHexString: newHexString)
        canvasView.updateSelectedRectangleViewColor(newColor: newUIColor)
    }
    
    @objc func updateSelectedRectangleViewAlpha(_ notification: Notification){
        guard let opacity = notification.userInfo?[Plane.UserInfoKey.rectangleAlphaUpdated] as? Int else { return }
        guard let canvasView = self.canvasView else { return }
        
        canvasView.updateSelectedRectangleOpacity(opacity: opacity)
    }
    
    @objc func updateSelectedRectangleViewPoint(_ notification: Notification){
        guard let canvasView = self.canvasView else { return }
        guard let selectedRectangle = notification.userInfo?[Plane.UserInfoKey.rectanglePointUpdated] as? RectangleApplicable else { return }
        canvasView.updateSelectedRectanglePoint(point:CGPoint(x: selectedRectangle.point.x, y: selectedRectangle.point.y))
    }

}

extension ViewController: UIGestureRecognizerDelegate{

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchedPoint = touch.location(in: self.canvasView)
        self.plane.findMatchingRectangleModel(x: touchedPoint.x, y: touchedPoint.y)
        return true
    }
    
    @objc private func panGestureRecognizer(_ sender: UIPanGestureRecognizer){
        let location = sender.location(in: canvasView)
    
        switch sender.state{
        case .began:
            self.startPanGesture(location: location)
        case .changed:
            self.changePanGesture(location: location)
        case .ended:
            self.endPanGesture(location: location)
        default:
            return
        }
    }
    
    private func startPanGesture(location: CGPoint){
        guard let canvasView = self.canvasView else { return }
        guard let rectangle: RectangleApplicable = self.plane[location.x, location.y] else { return }
        if let temporarySelectedRectangleView = RectangleViewFactory.createRectangleView(rectangle: rectangle){
            self.temporarySelectedRectangleView = temporarySelectedRectangleView
            canvasView.addSubview(temporarySelectedRectangleView)
        }

    }
    
    private func changePanGesture(location: CGPoint){
        if let temporarySelectedRectangleView = self.temporarySelectedRectangleView{
            temporarySelectedRectangleView.frame.origin = CGPoint(x: location.x, y: location.y)
            temporarySelectedRectangleView.alpha = 0.5
        }
    }
    
    private func endPanGesture(location: CGPoint){
        if let temporarySelectedRectangleView = self.temporarySelectedRectangleView{
            self.plane.updateSelectedRectanglePoint(x: temporarySelectedRectangleView.frame.origin.x, y: temporarySelectedRectangleView.frame.origin.y)
            temporarySelectedRectangleView.removeFromSuperview()
        }
        self.temporarySelectedRectangleView = nil
    }
    
}

extension ViewController: CanvasViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func creatingRectangleRequested(){
        guard let canvasView = self.canvasView else { return }
        plane.addColorRectangle(maxX: canvasView.bounds.maxX - 50,
                                maxY: canvasView.bounds.maxY - 250,
                                minWidth: 150,
                                minHeight: 150,
                                maxWidth: 180,
                                maxHeight: 180)
    }
    
    func pickingImageRequested(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        if let image = pickedImage{
            createImageRectangle(pickedImage: image)
        }
    }
    
    private func createImageRectangle(pickedImage: UIImage){
        guard let canvasView = self.canvasView else { return }
        guard let imageData = pickedImage.pngData() else { return }
        plane.addImageRectangle(maxX: canvasView.bounds.maxX - 50,
                                maxY: canvasView.bounds.maxY - 250,
                                minWidth: 150,
                                minHeight: 150,
                                maxWidth: 180,
                                maxHeight: 180,
                                image: imageData)
    }

}

extension ViewController: StylerViewDelegate{
    
    func updatingSelectedRectangleColorRequested(){
        let newColor = RectangleFactory.createRandomColor()
        self.plane.updateRectangleColor(newColor: newColor)
    }
    
    func updatingSelectedRectangleAlphaRequested(opacity: Int){
        self.plane.updateRectangleAlpha(opacity: opacity)
    }

}
