//
//  OptimizationViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 18/09/2023.
//

import Foundation
import UIKit
import Cloudinary

class OptimizationViewController: UIViewController {
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var lbOriginal: UILabel!
    @IBOutlet weak var lbOptimized: UILabel!
    @IBOutlet weak var ivOriginal: CLDUIImageView!
    @IBOutlet weak var ivOptimized: CLDUIImageView!

    var cloudinary: CLDCloudinary!

    override func viewDidLoad() {
        super.viewDidLoad()
//        initCloudinary()
//        setBackButton()
//        setOriginalImageView()
//        setOptimizedImageView()
    }

    func initCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2", secure: true))
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setOriginalImageView() {
        let url = cloudinary.createUrl().generate("4k_sample")
        ivOriginal.cldSetImage(url!, cloudinary: cloudinary)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        ivOriginal.isUserInteractionEnabled = true
        ivOriginal.addGestureRecognizer(gesture)

    }

    func setOptimizedImageView() {
        let url = cloudinary.createUrl().setTransformation(CLDTransformation().setQuality("auto").setFetchFormat("heic").setDpr("auto").setWidth(0.4).setCrop("scale")).generate("4k_sample")
        ivOptimized.cldSetImage(url!, cloudinary: cloudinary)
    }

    @objc func imageClicked() {
        guard let image = self.ivOriginal.image, let image2 = self.ivOptimized.image else {
            return
        }
        self.lbOriginal.text = "Original: \(Int(self.ivOriginal.image!.size.width))x\(Int(self.ivOriginal.image!.size.height)), \(FileUtils.getFileSizeForImage(image))MB"
        self.lbOptimized.text = "Optimized: \(Int(self.ivOptimized.image!.size.width))x\(Int(self.ivOptimized.image!.size.height)), \(FileUtils.getFileSizeForImage(image2))MB"
    }

    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}
