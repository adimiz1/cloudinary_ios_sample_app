//
//  ComplexTransformViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 18/09/2023.
//

import Foundation
import UIKit
import Cloudinary

class ComplexTransformViewController: UIViewController {
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var ivMain: CLDUIImageView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackButton()
        setImageView()
    }

    func setBackButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(stepBack))
        vwBack.addGestureRecognizer(gesture)
    }

    func setImageView() {
        let url = CloudinaryHelper.shared.cloudinary.createUrl()
            .setTransformation(CLDTransformation()
            .setWidth(400).setHeight(250).setGravity("south").setCrop("fill").chain()
            .setOverlay("nice_couple").setWidth(1.3).setHeight(1.3).setGravity("faces").setFlags("region_relative").setCrop("crop").chain()
            .setEffect("saturation:50").chain()
            .setEffect("vignette").chain()
            .setFlags("layer_apply").setWidth(100).setRadius("max").setGravity("center").setY(20).setX(-20).setCrop("scale").chain()
            .setOverlay("balloon").setHeight(55).chain()
            .setEffect("hue:-20").setAngle(5).chain()
            .setFlags("layer_apply").setX(30).setY(5).chain()
            .setOverlay("text:Cookie_40_bold:Love").setEffect("colorize").setColor("#f08").chain()
            .setAngle(20).setFlags("layer_apply").setX(-45).setY(44).chain()
            .setWidth(300).setHeight(250).setX(30).setCrop("crop").chain()
            .setRadius(60)).generate("coffee_cup.jpg")
        ivMain.cldSetImage(url!, cloudinary: CloudinaryHelper.shared.cloudinary)

    }

    @objc func stepBack() {
        self.dismiss(animated: true)
    }
}
