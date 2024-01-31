//
//  SingleUploadViewController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 11/01/2024.
//

import Foundation
import UIKit
import Photos
import Cloudinary

class SingleUploadViewController: UIViewController {

    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var vwOpenGallery: UIView!

    weak var delegate: UploadChoiceControllerDelegate!

    var url: String?

    var cloudinary: CLDCloudinary!

    var uploadLoadingView: UploadLoadingView?

    var type: UploadViewType = .Upload

    private var imagePicker: UIImagePickerController!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCloudinary()
        setOpenGalleryView()
        setImageView()
    }

    private func setImageView() {
        guard let url = url else {
            return
        }
        ivMain.cldSetImage(url , cloudinary: self.cloudinary)
    }

    private func setCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2"))
    }

    private func setOpenGalleryView() {
        vwOpenGallery.layer.cornerRadius = vwOpenGallery.frame.height / 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGalleryClicked))
        vwOpenGallery.addGestureRecognizer(tapGesture)
    }

    @objc private func openGalleryClicked() {
        if imagePicker == nil {
            imagePicker = UIImagePickerController()
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            if type == .UploadLarge {
                imagePicker.mediaTypes = ["public.movie"]
            }
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    private func addUploadingView() {
        let loadingViewSize = CGSize(width: 180, height: 70)
        let loadingViewOrigin = CGPoint(x: (vwImage.frame.width - loadingViewSize.width) / 2, y: (vwImage.frame.height - loadingViewSize.height) / 2)

        uploadLoadingView = UploadLoadingView(frame: CGRect(origin: loadingViewOrigin, size: loadingViewSize))
        uploadLoadingView!.startAnimation()
        vwImage.addSubview(uploadLoadingView!)
    }

    private func removeUploadingView() {
        if let uploadLoadingView = uploadLoadingView {
            AnimationHelper.animateOut(view: uploadLoadingView)
        }
    }

    func uploadImage(_ image: UIImage) {
        addUploadingView()
        let data = image.pngData()
        cloudinary.createUploader().upload(data: data!, uploadPreset: "ios_sample", completionHandler:  { response, _ in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.ivMain.cldSetImage( response!.secureUrl!, cloudinary: self.cloudinary)
                }
                self.removeUploadingView()
            }
        })
    }
}

extension SingleUploadViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        ivMain.image = nil
        uploadImage(image)
    }
}

