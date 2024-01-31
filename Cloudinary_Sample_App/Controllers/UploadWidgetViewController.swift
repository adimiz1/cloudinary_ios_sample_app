//
//  UploadWidgetViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 19/09/2023.
//

import Foundation
import UIKit
import Cloudinary

class UploadWidgetViewController: UIViewController {
    
    @IBOutlet weak var ivMain: CLDUIImageView!
    @IBOutlet weak var vwOpenGallery: UIView!
    
    var cloudinary: CLDCloudinary!
    var uploadWidget: CLDUploaderWidget!

    override func viewDidLoad() {
        super.viewDidLoad()
        setCloudinary()
        setUploadButton()
    }

    func setCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2"))
    }

    func setUploadButton() {
        vwOpenGallery.layer.cornerRadius = vwOpenGallery.frame.height / 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openUploadWidget))
        vwOpenGallery.addGestureRecognizer(tapGesture)
    }

    @objc func openUploadWidget() {
        let configuration = CLDWidgetConfiguration(
          uploadType: CLDUploadType(signed: false, preset: "ios_sample"))

        uploadWidget = CLDUploaderWidget(
          cloudinary: cloudinary,
          configuration: configuration,
          images: nil,
          delegate: self)

        uploadWidget.presentWidget(from: self)
    }


    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}

extension UploadWidgetViewController: CLDUploaderWidgetDelegate {
    func uploadWidget(_ widget: CLDUploaderWidget, willCall uploadRequests: [CLDUploadRequest]) {
      uploadRequests[0].response( { response, error in
          self.ivMain.cldSetImage(response!.secureUrl!, cloudinary: self.cloudinary)
      } )
    }
    func widgetDidCancel(_ widget: CLDUploaderWidget) {
    }
    func uploadWidgetDidDismiss() {
    }
}