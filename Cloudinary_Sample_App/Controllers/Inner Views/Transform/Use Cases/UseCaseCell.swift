//
//  UseCaseCell.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 30/01/2024.
//

import Foundation
import UIKit

class UseCaseCell: UICollectionViewCell {

    @IBOutlet weak var lbMain: UILabel!
    @IBOutlet weak var vwGradient: GradientView!

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
