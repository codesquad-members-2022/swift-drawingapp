//
//  MainViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit
import Photos
import PhotosUI

final class MainViewController: UIViewController, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var addButtonView: UIView!
    
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var buttonSetRandomColor: UIButton!
    @IBOutlet weak var sliderSetAlpha: UISlider!
    
    private var defaultButtonColor: UIColor!
    
    private var plane: Plane!
    private var currentIndex: Int?
    
    private var pickerViewController: PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            guard let self = self else { return }
            // 사진 앱의 권한을 모두 허용하거나, 일부 허용하였을 경우는 PHPickerViewController 호출이 가능하도록 한다.
            guard (status == .authorized || status == .limited) else { return }
            
            var conf = PHPickerConfiguration()
            conf.selectionLimit = 1
            conf.filter = PHPickerFilter.images
            
            DispatchQueue.main.async {
                self.pickerViewController = PHPickerViewController(configuration: conf)
                self.pickerViewController?.delegate = self
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: Plane.rectangleViewTouched,
            object: plane,
            queue: .current
        ) { [weak self] noti in
            guard let self = self else { return }
            
            self.currentIndex = noti.userInfo?[Plane.PostKey.index] as? Int
            OperationQueue.main.addOperation {
                self.processRectangleTouchedObserve((noti.userInfo as? [Plane.PostKey: Any]))
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: Plane.alphaDidChanged,
            object: plane,
            queue: .current
        ) { [weak self] noti in
            guard let self = self else { return }
            
            OperationQueue.main.addOperation {
                self.processRectangleTouchedObserve((noti.userInfo as? [Plane.PostKey: Any]))
            }
        }
    }
    
    private func processRectangleTouchedObserve(_ userInfo: [Plane.PostKey: Any]?) {
        guard let model = userInfo?[.model] as? RectangleProperty else {
            buttonSetRandomColor.backgroundColor = self.defaultButtonColor
            sliderSetAlpha.setValue(0, animated: true)
            return
        }
        
        let color = model.hasViewProperty ? defaultButtonColor : model.rgbValue.getColor(alpha: model.alpha)
        buttonSetRandomColor.backgroundColor = color
        sliderSetAlpha.setValue(Float(model.alpha), animated: true)
    }
    
    @IBAction func buttonForAddRectangleTouchUpInside(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @IBAction func buttonForAddPhotoTouchUpInside(_ sender: UIButton) {
        guard let pickerViewController = pickerViewController else {
            alert(message: "사진에 대한 권한이 없습니다. [설정] 앱을 확인해보시기 바랍니다.")
            return
        }
        
        self.present(pickerViewController, animated: true)
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        guard
            let index = currentIndex,
            let color = plane.resetRandomColor(at: index)
        else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = color.getColor(alpha: Double(sliderSetAlpha.value))
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        guard let index = currentIndex else { return }
        
        sender.value = round(sender.value)
        plane.setAlpha(value: sender.value, at: index)
    }
    
    private func alert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? MainScreenViewController else { return }
        
        var frame = self.view.frame
        frame.size = CGSize(
            width: (frame.width - panelView.frame.width),
            height: (frame.height - addButtonView.frame.height)
        )
        
        plane = Plane(sceneWidth: frame.width, sceneHeight: frame.height)
        vc.rectangleDelegate = plane
    }
    
    // MARK: - PHPickerViewControllerDelegate implementation
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        defer { picker.dismiss(animated: true) }
        
        guard
            let itemProvider = results.first?.itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self)
        else {
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { result, error in
            if error == nil, let result = result {
                self.plane.addRectangle(with: result)
            }
        }
    }
}
