//
//  Alpha.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

class Alpha:CustomStringConvertible,Decoable {
    
    var description: String {
        "Alpha: \(alpha)"
    }
    
    //최소 최대값은 고정되어 있어야 하기에 let으로 선언했습니다.
    //Alpha의 min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let minValue:Int = 0
    static let maxValue:Int = 10
    
    private var inputAlphaValue:Int
    
    //투명도는 0부터 10사이가 들어와야하므로 0보다 작은 수가 들어오면 0으로 10보다 큰 수가 들어오면 10으로 변환한다.
    var alpha:Int {
        translateInputAlphaValue()
    }
    
    //alpha값을 후에 바꾸고 싶다면 현재 보이고 있는 alpha값을 빠구는게 아니라, 다시 inputValue를 이용해서 계산해야 하므로 changeAlpha메서드를 선언했다.
    func changeAlpha(to newValue:Int) {
        self.inputAlphaValue = newValue
    }
    
    //가장큰값 maxValue보다 크면 maxValue로 가작 작은값 minValue보다 작으면 minValue를 주도록 했습니다.
    private func translateInputAlphaValue() -> Int{
        
        if self.inputAlphaValue < Alpha.minValue {
            return Alpha.minValue
        } else if inputAlphaValue > Alpha.maxValue {
            return Alpha.maxValue
        } else {
            return self.inputAlphaValue
        }
        
    }
    
    init(alpha:Int) {
        self.inputAlphaValue = alpha
    }
}
