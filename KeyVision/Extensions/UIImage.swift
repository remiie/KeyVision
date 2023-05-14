//
//  UIImage.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

extension UIImage {
    static func getImageWithColorPosition(color: UIColor, size: CGSize, lineSize: CGSize) -> UIImage {
            let rect = CGRect(x:0, y: 0, width: size.width, height: size.height)
            let rectLine = CGRect(x:0, y:size.height-lineSize.height,width: lineSize.width,height: lineSize.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            UIColor.clear.setFill()
            UIRectFill(rect)
            color.setFill()
            UIRectFill(rectLine)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
}
