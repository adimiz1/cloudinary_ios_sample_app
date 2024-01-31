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

    var type: OptimizationViewType = .Optimization

    var publicId: String = "4kimage"

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
        var url = cloudinary.createUrl().generate(publicId)
        if type == .FetchUpload {
            url = cloudinary.createUrl().setType("fetch").generate(publicId)
        }
        ivOriginal.cldSetImage(url!, cloudinary: cloudinary)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        ivOriginal.isUserInteractionEnabled = true
        ivOriginal.addGestureRecognizer(gesture)

        lbOriginalFormat.isHidden = true
        lbOriginalDimensions.isHidden = true
        lbOriginalSize.isHidden = true

    }

    func setOptimizedImageView() {
        var url = cloudinary.createUrl().setTransformation(CLDTransformation().setQuality("auto").setFetchFormat("auto").setDpr("auto").setWidth(0.4).setCrop("scale")).generate(publicId)
        if type == .FetchUpload {
            url = cloudinary.createUrl().setType("fetch").setTransformation(CLDTransformation().setQuality("auto").setFetchFormat("auto").setDpr("auto").setWidth(0.4).setCrop("scale")).generate(publicId)
        }
        ivOptimized.cldSetImage(url!, cloudinary: cloudinary)

        lbOptimizedFormat.isHidden = true
        lbOptimizedDimensions.isHidden = true
        lbOptimizedSize.isHidden = true
    }

    @objc func imageClicked() {
        guard let _ = self.ivOriginal.image, let _ = self.ivOptimized.image else {
            return
        }
        var originalUrl = cloudinary.createUrl().generate(publicId)!
        if type == .FetchUpload {
            originalUrl = cloudinary.createUrl().setType("fetch").generate(publicId)!
        }
        FileUtils.getImageFromat(URL(string: originalUrl)!) { format,size  in
            self.lbOriginalFormat.text = "\(format.uppercased()) ⏺"
            self.lbOriginalDimensions.text = "\(Int(self.ivOriginal.image!.size.width))x\(Int(self.ivOriginal.image!.size.height)) ⏺"
            self.lbOriginalSize.text = "\(size)MB"

            self.lbOriginalFormat.isHidden = false
            self.lbOriginalDimensions.isHidden = false
            self.lbOriginalSize.isHidden = false
        }
        var optimizedUrl = cloudinary.createUrl().setTransformation(CLDTransformation().setQuality("auto").setFetchFormat("auto").setDpr("auto").setWidth(0.4).setCrop("scale")).generate(publicId)!
        if type == .FetchUpload {
            optimizedUrl = cloudinary.createUrl().setType("fetch").setTransformation(CLDTransformation().setQuality("auto").setFetchFormat("auto").setDpr("auto").setWidth(0.4).setCrop("scale")).generate(publicId)!
        }
        FileUtils.getImageFromat(URL(string: optimizedUrl)!) { format, size in
            self.lbOptimizedFormat.text = "\(format.uppercased()) ⏺"
            self.lbOptimizedDimensions.text = "\(Int(self.ivOriginal.image!.size.width))x\(Int(self.ivOriginal.image!.size.height)) ⏺"
            self.lbOptimizedSize.text = "\(size)MB"

            self.lbOptimizedFormat.isHidden = false
            self.lbOptimizedDimensions.isHidden = false
            self.lbOptimizedSize.isHidden = false
        }
    }

    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}
