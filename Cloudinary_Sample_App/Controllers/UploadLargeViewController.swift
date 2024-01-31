//
//  UploadLargeViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 19/09/2023.
//

import Foundation
import UIKit
import Cloudinary
import AVKit
class UploadLargeViewController: UIViewController {

    @IBOutlet weak var vwVideoLayer: UIView!
    @IBOutlet weak var btnOpenGallery: UIButton!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var vwBack: UIView!

    var cloudinary: CLDCloudinary!
    var videoPicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCloudinary()
        setBackButton()
        setUploadButton()
    }

    func setCloudinary() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "adimizrahi2"))
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setUploadButton() {
        btnOpenGallery.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
    }

    @objc func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            videoPicker.delegate = self
            videoPicker.mediaTypes = ["public.movie"]
            videoPicker.sourceType = .photoLibrary
            videoPicker.allowsEditing = false
            present(videoPicker, animated: true, completion: nil)
        }
    }

    @objc func uploadVideo(_ url: URL) {
        aiLoading.isHidden = false
        let params = CLDUploadRequestParams()
        params.setResourceType(.video)
        
        cloudinary.createUploader().uploadLarge(url: url, uploadPreset: "ios_sample", params: params, chunkSize: 5 * 1024 * 1024, completionHandler:  { response, error in
            DispatchQueue.main.async {
                self.aiLoading.isHidden = true
                self.createVideoPlayer(url: response!.secureUrl!)
            }
        })
    }

    @objc func stepBack() {
        self.dismiss(animated: true)
    }

    func createVideoPlayer(url: String) {
        let player = CLDVideoPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        vwVideoLayer.backgroundColor = .black
        playerLayer.frame = self.vwVideoLayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        vwVideoLayer.layer.addSublayer(playerLayer)
        player.play()
    }
}

extension UploadLargeViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let url = info[.mediaURL] as? URL else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.uploadVideo(url)
    }


}
