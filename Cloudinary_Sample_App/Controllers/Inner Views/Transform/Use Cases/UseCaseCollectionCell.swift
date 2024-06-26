//
//  UseCaseCollectionCell.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 21/02/2024.
//

import Foundation
import UIKit

class UseCaseCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lbMain: UILabel!

    func setCellBy(index: Int) {
        switch index {
        case 0:
            lbMain.text = "Normalize Asset Sizing"
        case 1:
            lbMain.text = "Conditional Product Badging"
        case 2:
            lbMain.text = "Adapt to Screen Size"
        case 3:
            lbMain.text = "AI Generated Backgrounds"
        default:
            break
        }
    }
}
