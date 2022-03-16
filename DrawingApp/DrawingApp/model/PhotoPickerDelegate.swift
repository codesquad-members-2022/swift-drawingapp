//
//  PhotoFactory.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/14.
//

import Foundation
import UIKit

class PhotoPickerDelegate: NSObject{
    enum Notification{
        enum Event{
            static let getPhotoFromDevice = Foundation.Notification.Name("getPhotoFromDevice")
        }
        enum Key{
            case photoData
        }
    }
}
extension PhotoPickerDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // 수정된 이미지가 있을 경우
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // 오리지널 이미지가 있을 경우
            newImage = possibleImage
        }
        guard let pngData = newImage?.pngData() else {
            return
        }
        NotificationCenter.default.post(name: PhotoPickerDelegate.Notification.Event.getPhotoFromDevice, object: self, userInfo: [PhotoPickerDelegate.Notification.Key.photoData : pngData])
        picker.dismiss(animated: true)
    }
}
