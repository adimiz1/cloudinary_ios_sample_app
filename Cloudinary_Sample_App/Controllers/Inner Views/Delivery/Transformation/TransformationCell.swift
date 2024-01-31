//
//  TransformationCell.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 30/01/2024.
//

import Foundation
import UIKit

class TransformationCell: UICollectionViewCell {
    @IBOutlet weak var ivMain: UIImageView!

    func setMainImageView(_ image: UIImage?) {
        ivMain.image = image
    }
}
