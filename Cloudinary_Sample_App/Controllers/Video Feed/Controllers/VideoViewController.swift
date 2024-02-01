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

    @IBOutlet weak var vwVideoView: UIView!

    @IBOutlet weak var cvVideoFeed: UICollectionView!

    var collectionController: VideoFeedCollectionController!
    var player: CLDVideoPlayer!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setVideoView()
        setVideoFeedCollectionView()
    }

    private func setVideoView() {
        player = CLDVideoPlayer(url: "https://res.cloudinary.com/mobiledemoapp/video/upload/v1706627663/Demo%20app%20content/001_Smart_Cropping_08_jkyizb.mp4")
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.vwVideoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        vwVideoView.layer.addSublayer(playerLayer)
        player.isMuted = true
        player.play()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
    }

    private func setVideoFeedCollectionView() {
        collectionController = VideoFeedCollectionController()
        cvVideoFeed.delegate = collectionController
        cvVideoFeed.dataSource = collectionController
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        player.seek(to: .zero) // Seek to the beginning of the video
        player.play()
    }
}
