//
//  FileUtils.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 18/09/2023.
//

import Foundation
import UIKit
class FileUtils {
    static func getFileSizeForImage(_ image: UIImage) -> String {
        guard let imgData = image.jpegData(compressionQuality: 1.0) else {
            return ""
        }
        let imageSize: Int = imgData.count
        let size = Double(imageSize) / 1024.0 / 1024.0
        return "\(size.rounded(toPlaces: 2))"
    }
}
