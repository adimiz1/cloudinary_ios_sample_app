//
//  TransformCollectionCell.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 08/01/2024.
//

import Foundation
import UIKit
import Cloudinary
class TransformCollectionCell: UICollectionViewCell {

    @IBOutlet weak var lbMain: UILabel!
    @IBOutlet weak var ivMain: CLDUIImageView!

    func setCellBy(index: Int) {
        switch index {
        case 0:
            ivMain.cldSetImage(publicId: "Demo%20app%20content/content-aware-crop-4-ski_louxkt", cloudinary: CloudinaryHelper.shared.cloudinary, transformation: CLDTransformation().setCrop("thumb"))
            lbMain.text = "Smart Cropping"
        case 1:
            ivMain.cldSetImage(publicId: "Demo%20app%20content//layers-backpack_ruek7e", cloudinary: CloudinaryHelper.shared.cloudinary, transformation: CLDTransformation().setCrop("thumb"))
            lbMain.text = "Localization & branding"
        case 2:
            ivMain.cldSetImage(publicId: "Demo%20app%20content/bgr-furniture-1_isnptj", cloudinary: CloudinaryHelper.shared.cloudinary, transformation: CLDTransformation().setCrop("thumb"))
            lbMain.text = "Background normalizing"
        case 3:
            ivMain.cldSetImage(publicId: "Demo%20app%20content/recolor-tshirt-5_omapls", cloudinary: CloudinaryHelper.shared.cloudinary, transformation: CLDTransformation().setCrop("thumb"))
            lbMain.text = "Color Alternation"
        default:
            break
        }
    }
}
