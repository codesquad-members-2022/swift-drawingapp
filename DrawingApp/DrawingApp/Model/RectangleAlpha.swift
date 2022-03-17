import Foundation

struct Alpha: CustomStringConvertible{
    enum Opacity:Float, CaseIterable{
        
        case one = 0.1
        case two = 0.2
        case three = 0.3
        case four = 0.4
        case five = 0.5
        case six = 0.6
        case seven = 0.7
        case eight = 0.8
        case nine = 0.9
        case ten = 1.0

    }
    
    var opacity: Opacity = .ten
    var description: String{
        return "Alpha:\(String(self.opacity.rawValue))"
    }
    
    init(opacity: Int){
        self.opacity = Opacity.allCases[adjustRange(value: opacity)]
    }
    
    private func adjustRange(value: Int)->Int{
        if(value<0){
            return 0
        }else if(value >= Opacity.allCases.count){
            return Opacity.allCases.count - 1
        }else{
            return value
        }
    }
}
