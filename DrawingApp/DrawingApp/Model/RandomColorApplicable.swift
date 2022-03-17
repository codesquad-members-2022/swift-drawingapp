import Foundation

protocol RandomColorApplicable{
    var backgroundColor: Color {get}
    func updateBackgroundColor(newColor: Color)
}
