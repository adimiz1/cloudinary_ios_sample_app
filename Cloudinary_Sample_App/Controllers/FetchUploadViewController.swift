//
//  FetchUploadViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 19/09/2023.
//

import Foundation
import UIKit
import Cloudinary

class FetchUploadViewController: UIViewController {
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var ivOriginal: CLDUIImageView!
    @IBOutlet weak var btnFetch: UIButton!
    @IBOutlet weak var ivFetched: CLDUIImageView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackButton()
        setFetchButton()
        setImageView()
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setFetchButton() {
        btnFetch.addTarget(self, action: #selector(fetchImage), for: .touchUpInside)
    }

    func setImageView() {
        ivOriginal.cldSetImage("https://upload.wikimedia.org/wikipedia/commons/1/13/Benedict_Cumberbatch_2011.png", cloudinary: CloudinaryHelper.shared.cloudinary)

    }

    @objc func fetchImage() {
        let transformedUrl = CloudinaryHelper.shared.cloudinary.createUrl().setType( "fetch").setTransformation(CLDTransformation().setEffect("sepia")).generate("https://upload.wikimedia.org/wikipedia/commons/1/13/Benedict_Cumberbatch_2011.png")
        ivFetched.cldSetImage(transformedUrl!, cloudinary: CloudinaryHelper.shared.cloudinary)
    }

    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}
