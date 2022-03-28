//
//  BaseView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import UIKit

enum ViewFactory {
    static func create(from Layer: Layer) -> UIView? {
        switch Layer {
        case let rectangle as Rectangle:
            return createView(from: rectangle)
        case let photo as Photo:
            return createView(from: photo)
        case let label as Label:
            return createView(from: label)
        case let postIt as PostIt:
            return createView(from: postIt)
        default:
            return nil
        }
    }
    
    private static func createView(from rectangle: Rectangle) -> UIView {
        let frame = CGRect(origin: rectangle.origin, size: rectangle.size)
        let view = UIView(frame: frame)
        
        view.backgroundColor = UIColor(with: rectangle.color)
        view.alpha = CGFloat(with: rectangle.alpha)
        
        return view
    }
    
    private static func createView(from photo: Photo) -> UIImageView {
        let frame = CGRect(origin: photo.origin, size: photo.size)
        let view = UIImageView(frame: frame)
        
        view.image = UIImage(data: photo.data)
        view.alpha = CGFloat(with: photo.alpha)
        
        return view
    }
    
    private static func createView(from label: Label) -> UILabel {
        let frame = CGRect(origin: label.origin, size: label.size)
        let view = UILabel(frame: frame)
        
        view.text = label.getText
        view.font = UIFont.systemFont(ofSize: CGFloat(label.fontSize))
        
        return view
    }
    
    private static func createView(from postIt: PostIt) -> UITextView {
        let frame = CGRect(origin: postIt.origin, size: postIt.size)
        let view = UITextView(frame: frame)
        
        view.text = postIt.getText
        view.isEditable = false
        view.backgroundColor = UIColor(with: postIt.color)
        view.textColor = UIColor(with: postIt.color).isDark ? .white : .black
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        view.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        UIView.addShadow(to: view)
        
        return view
    }
    
    static func createSymbol(from layer: Layer) -> UIImage? {
        switch layer {
        case _ as Rectangle:
            return UIImage(systemName: "rectangle")
        case _ as Photo:
            return UIImage(systemName: "photo.artframe")
        case _ as Label:
            return UIImage(systemName: "character.textbox")
        case _ as PostIt:
            return UIImage(systemName: "text.bubble.fill")
        default:
            return nil
        }
    }
}
