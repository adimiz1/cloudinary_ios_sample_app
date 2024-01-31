//
//  PreProcessingViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 19/09/2023.
//

import Foundation
import UIKit
import Cloudinary


class PreProcessingViewController: UIViewController {

    @IBOutlet weak var lbOriginal: UILabel!
    @IBOutlet weak var ivOriginal: CLDUIImageView!
    @IBOutlet weak var lbModified: UILabel!
    @IBOutlet weak var ivModified: CLDUIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!


    var cloudinary: CLDCloudinary!

    override func viewDidLoad() {
        super.viewDidLoad()
        setCloudinary()
        setBackButton()
        setUploadButton()
        setOriginalImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.lbOriginal.text = "Original \(Int(self.ivOriginal.image!.size.width)) x \(Int(self.ivOriginal.image!.size.height))"
        }
    }

    func setOriginalImage() {
        ivOriginal.image = UIImage(named: "yellow-car")
    }

    func setCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2"))
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setUploadButton() {
        btnUpload.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
    }

    func preprocessImage() -> CLDImagePreprocessChain {
        let preprocessChain = CLDImagePreprocessChain()
            .addStep(CLDPreprocessHelpers.limit(width: 500, height: 500))
            .addStep(CLDPreprocessHelpers.rotate(degrees: 180))
            .addStep(CLDPreprocessHelpers.dimensionsValidator(minWidth: 10, maxWidth: 500, minHeight: 10, maxHeight: 500))
            .setEncoder(CLDPreprocessHelpers.customImageEncoder(format: EncodingFormat.PNG, quality: 70))
        return preprocessChain
    }

    @objc func uploadImage() {
        let preprocessChain = preprocessImage()
        aiLoading.isHidden = false
        let image = UIImage(named: "yellow-car")
        let data = image?.pngData()
        cloudinary.createUploader().upload(data: data!, uploadPreset: "ios_sample", preprocessChain: preprocessChain, completionHandler:  { response, _ in
            DispatchQueue.main.async {
                self.ivModified.cldSetImage( response!.secureUrl!, cloudinary: self.cloudinary)
                self.aiLoading.isHidden = true
                self.lbModified.text = "Modified \(Int(response!.width!)) x \(Int(response!.height!))"
            }
        })
    }


    @objc func stepBack() {
        self.dismiss(animated: true)
    }

}
