//
//  ViewController.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/15.
//

import UIKit

class CanvasViewController: UIViewController {
    
    private var plane : Plane!
    private var makeUsecase: MakeUsecase!
    private var propertyUsecase: PropertyUsecase!
    private var observers = [NSObjectProtocol]()
    private var viewMapById = [UUID:UIView]()
    private var planeView : PlaneView {
        return self.view as! PlaneView
    }
    @IBOutlet weak var objectList: UIView!
    private weak var objectViewController: ObjectListViewController!
    
    @IBOutlet weak var sidebar: UIView!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBOutlet weak var menuDrawing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapSelector()
        configurePlane()
        configurePlaneView()
        configureSidebar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "objectList",
              let destination = segue.destination as? ObjectListViewController else { return }
        self.objectViewController = destination
    }
    
    private func configureTapSelector() {
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapped))
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
    }

    private func configurePlane() {
        self.plane = Plane()
        self.objectViewController.objectSource = plane
        self.makeUsecase = MakeUsecase(makerable: plane)
        self.propertyUsecase = PropertyUsecase(touchable: plane)
        self.observers.append(NotificationCenter.default.addObserver(forName: Plane.Notifications.addedNewRectangle, object: plane, queue: .main) { notification in
            guard let rect = notification.userInfo?[Plane.Keys.Element] as? BaseRect & RectColorful else { return }
            self.makeRectView(with: rect)
        })
        self.observers.append(NotificationCenter.default.addObserver(forName: Plane.Notifications.addedNewPicture, object: plane, queue: .main) { notification in
            guard let rect = notification.userInfo?[Plane.Keys.Element] as? BaseRect & PictureAccessable else { return }
            self.makePictureView(with: rect)
        })
        self.observers.append(NotificationCenter.default.addObserver(forName: Plane.Notifications.addedNewDrawing, object: plane, queue: .main) { notification in
            guard let rect = notification.userInfo?[Plane.Keys.Element] as? BaseRect & RectColorful & PointAccessable else { return }
            self.makeDrawingView(with: rect)
        })
        self.observers.append(NotificationCenter.default.addObserver(forName: Plane.Notifications.didChangeColor, object: plane, queue: .main) { notification in
            guard let rect = notification.userInfo?[Plane.Keys.Element] as? BaseRect & RectColorful else { return }
            guard let colorRect = self.viewMapById[rect.id] as? ColorfulView else { return }
            colorRect.changeColor(with: rect.color)
            let color = UIColor(cgColor: rect.color)
            self.changeColorButton(with: color)
        })
        self.observers.append(NotificationCenter.default.addObserver(forName: Plane.Notifications.didSelectRectangle, object: plane, queue: .main) { notification in
            guard let rect = notification.userInfo?[Plane.Keys.Element] as? BaseRect else { return }
            self.selectBy(rect: rect)
        })
        self.observers.append(NotificationCenter.default.addObserver(forName: Plane.Notifications.didDeselectRectangle, object: plane, queue: .main) { notification in
            self.deselectAll()
        })
    }
    
    private func configurePlaneView() {
        planeView.delegate = self
    }
    
    private func configureSidebar() {
        UIView.animate(withDuration: 0.4) {
            self.sidebar.transform = CGAffineTransform.init(translationX: 200, y: 0)
            self.objectList.transform = CGAffineTransform.init(translationX: -200, y: 0)
        }
    }
        
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        _ = propertyUsecase.tapped(at: point)
    }
    
    @IBAction func touchedForRectangle(_ sender: Any) {
        makeUsecase.addRect()
        objectViewController.reloadView()
    }
    
    @IBAction func touchedForPicture(_ sender: Any) {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func touchedForDrawing(_ sender: Any) {
        planeView.toggleDrawingMode()
        menuDrawing.isSelected.toggle()
    }
    
    @IBAction func touchedForColor(_ sender: Any) {
        propertyUsecase.changeColor(with: CGColor.random())
    }
}

//Mark:- Presenter
fileprivate extension CanvasViewController {
    private func makeRectView(with value: BaseRect & RectColorful) {
        let view = ViewFactory.makeRect(with: value)
        self.view.insertSubview(view, belowSubview: sidebar)
        self.viewMapById[value.id] = view
    }
    
    private func makePictureView(with value: BaseRect & PictureAccessable) {
        let view = ViewFactory.makePicture(with: value)
        self.view.insertSubview(view, belowSubview: sidebar)
        self.viewMapById[value.id] = view
    }
    
    private func makeDrawingView(with value: BaseRect & RectColorful & PointAccessable) {
        let view = ViewFactory.makeDrawing(with: value)
        self.view.insertSubview(view, belowSubview: sidebar)
        self.viewMapById[value.id] = view
    }
    
    private func changeColorButton(with color: UIColor) {
        colorButton.tintColor = color
        colorButton.setTitle(color.hexCode(), for: .normal)
        colorButton.titleLabel?.sizeToFit()
    }
    
    private func selectBy(rect: BaseRect) {
        guard let selectedView = viewMapById[rect.id] else { return }
        planeView.deselectAll()
        colorButton.setTitle("", for: .normal)
        colorButton.tintColor = UIColor.gray
        selectedView.layer.borderColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        selectedView.layer.borderWidth = 3
        UIView.animate(withDuration: 0.4) {
            self.sidebar.transform = CGAffineTransform.identity
            self.objectList.transform = CGAffineTransform.identity
        }
        self.objectViewController.reloadView()
        guard let colorRect = rect as? RectColorful else { return }
        let color = UIColor(cgColor: colorRect.color)
        changeColorButton(with: color)
    }
    
    private func deselectAll() {
        planeView.deselectAll()
        colorButton.setTitle("", for: .normal)
        colorButton.tintColor = UIColor.gray
        UIView.animate(withDuration: 0.4) {
            self.sidebar.transform = CGAffineTransform.init(translationX: 200, y: 0)
            self.objectList.transform = CGAffineTransform.init(translationX: -200, y: 0)
        }
    }
}

extension CanvasViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view?.isDescendant(of: objectList) != true
    }
}

extension CanvasViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        makeUsecase.addPicture(with: mediaURL)
        objectViewController.reloadView()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CanvasViewController : DrawingDelegate {
    func planeBeganDrawing(_ planeView: PlaneView) {
    }
    
    func planeEndedDrawing(_ planeView: PlaneView, points: [CGPoint]) {
        planeView.toggleDrawingMode()
        menuDrawing.isSelected = false
        makeUsecase.addDrawing(with: points)
        objectViewController.reloadView()
    }
}

