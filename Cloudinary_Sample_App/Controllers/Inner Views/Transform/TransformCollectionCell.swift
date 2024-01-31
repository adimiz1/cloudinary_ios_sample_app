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
            ivMain.image = UIImage(named: "ski")
            lbMain.text = "Smart Cropping"
        case 1:
            ivMain.image = UIImage(named: "bag")
            lbMain.text = "Localization & branding"
        case 2:
            ivMain.image = UIImage(named: "sofa")
            lbMain.text = "Background normalizing"
        case 3:
            ivMain.image = UIImage(named: "lady")
            lbMain.text = "Color Alternation"
        default:
            break
        }
    }
}
