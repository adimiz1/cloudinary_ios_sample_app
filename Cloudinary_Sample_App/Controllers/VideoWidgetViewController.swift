//
//  VideoWidgetViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 19/09/2023.
//

import Foundation
import UIKit
import Cloudinary
import AVKit

class VideoWidgetViewController: UIViewController {
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var vwVideoLayer: UIView!
    @IBOutlet weak var vwVideoController: UIView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackButton()
        setVideoPlayers()
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setVideoPlayers() {
        setVideoPlayerInController()
        setVideoPlayerInLayer()
    }

    func setVideoPlayerInController() {
        let player = CLDVideoPlayer(url:"https://res.cloudinary.com/demo/video/upload/sp_auto:subtitles_(code_en-US;file_docs:narration.vtt)/sea_turtle.m3u8")
        player.appliesMediaSelectionCriteriaAutomatically = true
        let playerController = AVPlayerViewController()
        playerController.player = player
        addChild(playerController)
        playerController.videoGravity = .resizeAspectFill
        vwVideoController.addSubview(playerController.view)
        playerController.view.frame = vwVideoController.bounds
        playerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerController.didMove(toParent: self)
        //player.play()
    }

    func setVideoPlayerInLayer() {
        let player = CLDVideoPlayer(url: "https://res.cloudinary.com/demo/video/upload/sp_auto/dog.m3u8")
        let playerLayer = AVPlayerLayer(player: player)
        vwVideoLayer.backgroundColor = .black
        playerLayer.frame = self.vwVideoLayer.bounds
        playerLayer.player?.isMuted = true
        playerLayer.videoGravity = .resizeAspectFill
        vwVideoLayer.layer.addSublayer(playerLayer)
        player.play()
    }


    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}
