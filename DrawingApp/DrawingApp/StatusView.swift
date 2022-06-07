import UIKit

class StatusView: UIView {
    
    private let backgroundTitle = UILabel()
    
    private let backgroundContent = UITextField()
    
    private let alphaTitle = UILabel()
    
    private let alphaContent = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemYellow
        
        backgroundTitle.text = "배경색"
        backgroundContent.text = "#D5DFE9"
        alphaTitle.text = "투명도"
        alphaContent.text = "#D5DFE9"
        
        NSLayoutConstraint.activate([
            self.backgroundTitle.topAnchor.constraint(equalTo: self.topAnchor),
            
        ])
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
