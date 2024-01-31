//
//  VideoViewController.swift
//  ios-video-testing
//
//  Created by Adi Mizrahi on 16/11/2023.
//

import Foundation
import UIKit
import Cloudinary
import AVKit

class VideoViewController: UIViewController {

    var url: String = ""
    var player: CLDVideoPlayer!

  static func getInstance(url: String) -> UIViewController {
    let vc = UIStoryboard(name: "VideoFeed", bundle: nil).instantiateViewController(identifier: "VideoViewController") as! VideoViewController
    vc.url = url
    return vc
  }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        player.play()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()
    }

    func setPlayer() {
        guard let url = URL(string: url) else {
            return
        }
        player = CLDVideoPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        player.isMuted = true
    }

    func playVideo() {
        player.play()
    }
}
