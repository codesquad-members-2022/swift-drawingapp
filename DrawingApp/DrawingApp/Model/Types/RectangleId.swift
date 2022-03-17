import Foundation

struct Id:CustomStringConvertible, Hashable{
    private var idValue: String
    var description: String{
        return self.idValue
    }
    
    init(){
        var asciiValues: [Int] = []
        asciiValues.append(contentsOf: Array(97...122))
        asciiValues.append(contentsOf: Array(48...57))
        
        var characters: [Character] = []
        while(characters.count != 9){
            guard let value = UnicodeScalar(asciiValues[Int.random(in: 0..<asciiValues.count)]) else { continue }
            let character = Character(value)
            characters.append(character)
        }
        self.idValue = "\(String(characters[0...2]))-\(String(characters[3...5]))-\(String(characters[6...8]))"
    }
}
