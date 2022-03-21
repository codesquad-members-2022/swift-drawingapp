import Foundation
import UIKit

class StylerView: UIView{
    
    weak var delegate: StylerViewDelegate?
    private var rectangleColorTextLabel: UILabel = UILabel()
    private var rectangleColorValueField: UIButton = UIButton()
    private var rectangleAlphaTextLabel: UILabel = UILabel()
    private var rectangleAlphaSlider: UISlider = UISlider()
    private var rectanglePointXLabel: UILabel = UILabel()
    private var rectanglePointXValueField: UILabel = UILabel()
    private var rectanglePointXIncreaseButton: UIButton = UIButton()
    private var rectanglePointXDecreaseButton: UIButton = UIButton()
    private var rectanglePointYLabel: UILabel = UILabel()
    private var rectanglePointYValueField: UILabel = UILabel()
    private var rectanglePointYIncreaseButton: UIButton = UIButton()
    private var rectanglePointYDecreaseButton: UIButton = UIButton()
    
    init(frame: CGRect, backgroundColor: UIColor){
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        setRectangleColorInformationView()
        setColorChangeAction()
        setRectangleAlphaInformationView()
        setAlphaChangeAction()
        setRectanglePointInformationView()
        setRectanglePointChangeAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func clearSelectedRectangleInfo(){
        self.rectangleAlphaSlider.value = 0
        self.rectangleColorValueField.backgroundColor = .white
        self.rectangleColorValueField.setTitle("", for: .normal)
    }
    
    func updateColorRectangleInfo(r: Double, g: Double, b: Double, opacity: Float, hexString: String){
        self.rectangleColorValueField.setTitle(hexString, for: .normal)
        self.rectangleColorValueField.titleLabel?.textAlignment = .center
        self.rectangleColorValueField.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        self.rectangleAlphaSlider.value = opacity
    }
    
    func updateImageRectangleInfo(opacity: Float){
        self.rectangleColorValueField.setTitle("", for: .normal)
        self.rectangleColorValueField.backgroundColor = .darkGray
        self.rectangleAlphaSlider.value = opacity
    }
    
    func updateRectanglePointInfo(rectangle: RectangleApplicable){
        self.rectanglePointXValueField.text = String(Int(rectangle.point.x))
        self.rectanglePointYValueField.text = String(Int(rectangle.point.y))
    }
    
    private func setRectangleColorInformationView(){
        self.rectangleColorTextLabel.text = "배경색"
        self.rectangleColorTextLabel.frame = CGRect(x: self.frame.width*0.1,
                                                    y: self.frame.height*0.07,
                                                    width: 100,
                                                    height: self.frame.height*0.05)
        self.addSubview(self.rectangleColorTextLabel)
        
        self.rectangleColorValueField.frame = CGRect(x: self.frame.width*0.1,
                                                     y: self.rectangleColorTextLabel.frame.maxY+10,
                                                     width: self.frame.width*0.75,
                                                     height: self.frame.height*0.05)
        self.rectangleColorValueField.layer.cornerRadius = 10
        self.rectangleColorValueField.layer.borderWidth = 1
        self.addSubview(self.rectangleColorValueField)
    }
    
    private func setColorChangeAction(){
        self.rectangleColorValueField.addAction(UIAction(title: ""){_ in
            if let delegate = self.delegate{
                delegate.updatingSelectedRectangleColorRequested()
            }
        }, for: .touchDown)
    }
    
    private func setRectangleAlphaInformationView(){
        self.rectangleAlphaTextLabel.text = "투명도"
        self.rectangleAlphaTextLabel.frame = CGRect(x: self.frame.width*0.1,
                                                    y: self.rectangleColorValueField.frame.maxY+25,
                                                    width: 100,
                                                    height: self.frame.height*0.05)
        self.addSubview(self.rectangleAlphaTextLabel)
        
        self.rectangleAlphaSlider.frame = CGRect(x: self.frame.width*0.1,
                                                 y: self.rectangleAlphaTextLabel.frame.maxY+10,
                                                 width: self.frame.width*0.75,
                                                 height: 10)
        self.rectangleAlphaSlider.value = 10
        self.addSubview(self.rectangleAlphaSlider)
    }
    
    private func setAlphaChangeAction(){
        self.rectangleAlphaSlider.addAction(UIAction(title: ""){ _ in
            if let delegate = self.delegate{
                delegate.updatingSelectedRectangleAlphaRequested(opacity: Int(self.rectangleAlphaSlider.value * 10))
            }
        }, for: .valueChanged)
    }
    
    private func setRectanglePointInformationView(){
        self.rectanglePointXLabel.text = "X: "
        self.rectanglePointYLabel.text = "Y: "
        self.rectanglePointXIncreaseButton.setTitle("🔼", for: .normal)
        self.rectanglePointXDecreaseButton.setTitle("🔽", for: .normal)
        self.rectanglePointYIncreaseButton.setTitle("🔼", for: .normal)
        self.rectanglePointYDecreaseButton.setTitle("🔽", for: .normal)
        
        self.rectanglePointXLabel.frame = CGRect(x: self.frame.width*0.1,
                                                 y: self.rectangleAlphaSlider.frame.maxY + 40,
                                                 width: 30,
                                                 height: self.frame.height*0.06)
        self.rectanglePointXValueField.frame = CGRect(x: self.rectanglePointXLabel.frame.minX+30,
                                                      y: self.rectanglePointXLabel.frame.minY,
                                                      width: self.frame.width*0.4,
                                                      height: self.frame.height*0.06)
        self.rectanglePointXIncreaseButton.frame = CGRect(x: self.rectanglePointXValueField.frame.maxX,
                                                          y: self.rectanglePointXLabel.frame.minY,
                                                          width: self.frame.height*0.06,
                                                          height: self.frame.height*0.03)
        self.rectanglePointXDecreaseButton.frame = CGRect(x: self.rectanglePointXValueField.frame.maxX,
                                                          y: self.rectanglePointXIncreaseButton.frame.maxY,
                                                          width: self.frame.height*0.06,
                                                          height: self.frame.height*0.03)
        self.rectanglePointYLabel.frame = CGRect(x: self.frame.width*0.1,
                                                 y: self.rectanglePointXLabel.frame.maxY + 10,
                                                 width: 30,
                                                 height: self.frame.height*0.06)
        self.rectanglePointYValueField.frame = CGRect(x: self.rectanglePointYLabel.frame.minX+30,
                                                      y: self.rectanglePointYLabel.frame.minY,
                                                      width: self.frame.width*0.4,
                                                      height: self.frame.height*0.06)
        self.rectanglePointYIncreaseButton.frame = CGRect(x: self.rectanglePointYValueField.frame.maxX,
                                                          y: self.rectanglePointYLabel.frame.minY,
                                                          width: self.frame.height*0.06,
                                                          height: self.frame.height*0.03)
        self.rectanglePointYDecreaseButton.frame = CGRect(x: self.rectanglePointYValueField.frame.maxX,
                                                          y: self.rectanglePointYIncreaseButton.frame.maxY,
                                                          width: self.frame.height*0.06,
                                                          height: self.frame.height*0.03)

        
        self.addSubview(self.rectanglePointXLabel)
        self.addSubview(self.rectanglePointXValueField)
        self.addSubview(self.rectanglePointXIncreaseButton)
        self.addSubview(self.rectanglePointXDecreaseButton)
        self.addSubview(self.rectanglePointYLabel)
        self.addSubview(self.rectanglePointYValueField)
        self.addSubview(self.rectanglePointYIncreaseButton)
        self.addSubview(self.rectanglePointYDecreaseButton)
    }
    
    func setRectanglePointChangeAction(){
        self.rectanglePointXIncreaseButton.addAction(UIAction(title: ""){_ in
            guard let delegate = self.delegate else { return }
            delegate.updatingSelectedRectanglePointXRequested(increase: true)
        }, for: .touchDown)
        self.rectanglePointXDecreaseButton.addAction(UIAction(title: ""){_ in
            guard let delegate = self.delegate else { return }
            delegate.updatingSelectedRectanglePointXRequested(increase: false)
        }, for: .touchDown)
        self.rectanglePointYIncreaseButton.addAction(UIAction(title: ""){_ in
            guard let delegate = self.delegate else { return }
            delegate.updatingSelectedRectanglePointYRequested(increase: false)
        }, for: .touchDown)
        self.rectanglePointYDecreaseButton.addAction(UIAction(title: ""){_ in
            guard let delegate = self.delegate else { return }
            delegate.updatingSelectedRectanglePointYRequested(increase: true)
        }, for: .touchDown)
    }
    
    func updateSelectedRectangleViewColorInfo(newColor: UIColor, newHexString: String){
        self.rectangleColorValueField.backgroundColor = newColor
        self.rectangleColorValueField.setTitle(newHexString, for: .normal)
    }
    
    func updateSelectedRectangleViewPointInfo(point: CGPoint){
        self.rectanglePointXValueField.text = "\(Int(point.x))"
        self.rectanglePointYValueField.text = "\(Int(point.y))"
    }
}
