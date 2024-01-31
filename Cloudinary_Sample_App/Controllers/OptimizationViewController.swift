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

    @IBOutlet weak var lbOriginalFormat: UILabel!
    @IBOutlet weak var lbOriginalDimensions: UILabel!
    @IBOutlet weak var lbOriginalSize: UILabel!

    @IBOutlet weak var lbOptimizedFormat: UILabel!
    @IBOutlet weak var lbOptimizedDimensions: UILabel!
    @IBOutlet weak var lbOptimizedSize: UILabel!

    var cloudinary: CLDCloudinary!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCloudinary()
        setOriginalImageView()
        setOptimizedImageView()
    }

    func initCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2", secure: true))
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setOriginalImageView() {
        let url = cloudinary.createUrl().generate("4kimage")
        ivOriginal.cldSetImage(url!, cloudinary: cloudinary)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        ivOriginal.isUserInteractionEnabled = true
        ivOriginal.addGestureRecognizer(gesture)

    }

    func setOptimizedImageView() {
        let url = cloudinary.createUrl().setTransformation(CLDTransformation().setQuality("auto").setFetchFormat("heic").setDpr("auto").setWidth(0.4).setCrop("scale")).generate("4kimage")
        ivOptimized.cldSetImage(url!, cloudinary: cloudinary)
    }

    @objc func imageClicked() {
        guard let _ = self.ivOriginal.image, let _ = self.ivOptimized.image else {
            return
        }
        FileUtils.getImageFromat(URL(string: cloudinary.createUrl().generate("4kimage")!)!) { format,size  in
            self.lbOriginalFormat.text = "\(format.uppercased()) ⏺"
            self.lbOriginalDimensions.text = "\(Int(self.ivOriginal.image!.size.width))x\(Int(self.ivOriginal.image!.size.height)) ⏺"
            self.lbOriginalSize.text = "\(size)MB"
        }
        FileUtils.getImageFromat(URL(string: cloudinary.createUrl().setTransformation(CLDTransformation().setFetchFormat("auto")).generate("4kimage")!)!) { format, size in
            self.lbOptimizedFormat.text = "\(format.uppercased()) ⏺"
            self.lbOptimizedDimensions.text = "\(Int(self.ivOriginal.image!.size.width))x\(Int(self.ivOriginal.image!.size.height)) ⏺"
            self.lbOptimizedSize.text = "\(size)MB"
        }
    }

    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}
