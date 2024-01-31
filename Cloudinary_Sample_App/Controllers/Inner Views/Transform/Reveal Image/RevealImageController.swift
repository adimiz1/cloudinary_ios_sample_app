//
//  RevealImageController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 30/01/2024.
//

import Foundation
import UIKit

class RevealImageController: UIViewController {

    @IBOutlet weak var ivMain: RevealImageView!

    func setMainImageView(rightImage: UIImage?, leftImage: UIImage?) {
        ivMain.rightImage = rightImage
        ivMain.leftImage = leftImage
//        ImageHelper.getImageFromURL(URL(string: "https://res.cloudinary.com/adimizrahi2/image/upload/f_jxl/dog5")!) { image in
//            DispatchQueue.main.async {
//                self.ivMain.rightImage = image
//            }
//        }
//        ImageHelper.getImageFromURL(URL(string: "https://res.cloudinary.com/adimizrahi2/image/upload/f_jxl/dog5")!) { image in
//            DispatchQueue.main.async {
//                self.ivMain.leftImage = image
//            }
//        }
    }

}
