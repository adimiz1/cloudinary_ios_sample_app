//
//  UploadDoesNotExistController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 30/01/2024.
//

import Foundation
import UIKit
import Cloudinary

class UploadDoesNotExistController: UIViewController {
    @IBOutlet weak var vwUpload: UIView!

    private var imagePicker: UIImagePickerController!

    weak var delegate: UploadChoiceControllerDelegate!

    var cloudinary: CLDCloudinary!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCloudinary()
        setUploadImageView()
    }

    private func setCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2"))
    }

    func setUploadImageView() {
        vwUpload.layer.cornerRadius = vwUpload.frame.height / 2

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadClicked))
        vwUpload.addGestureRecognizer(tapGesture)
    }

    @objc private func uploadClicked() {
        if imagePicker == nil {
            imagePicker = UIImagePickerController()
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func uploadImage(_ image: UIImage) {
        let data = image.pngData()
        cloudinary.createUploader().upload(data: data!, uploadPreset: "ios_sample", completionHandler:  { response, _ in
            DispatchQueue.main.async {
                self.delegate.switchToController(.UploadExist, url: response?.secureUrl)
            }
        })
    }
}

extension UploadDoesNotExistController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        uploadImage(image)
    }
}
