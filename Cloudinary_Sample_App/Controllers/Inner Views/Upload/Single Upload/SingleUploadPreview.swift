//
//  SingleUploadPreview.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 12/05/2024.
//

import Foundation
import UIKit
import Cloudinary
import AVKit

class SingleUploadPreview: UIViewController {

    var url: String!
    var cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: CloudinaryHelper.shared.getUploadCloud()!))

    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var ivMain: CLDUIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if url.contains("video") {
                        let player = CLDVideoPlayer(url: url)
                            let playerController = AVPlayerViewController()
            
                            playerController.player = player
                            addChild(playerController)
                            playerController.videoGravity = .resizeAspect
                            vwImage.addSubview(playerController.view)
                            playerController.view.frame = vwImage.bounds
                            playerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                            playerController.didMove(toParent: self)
                            player.play()
        } else {
            ivMain.cldSetImage(url, cloudinary: cloudinary)
        }
    }
}
