//
//  CloudinaryHelper.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 12/09/2023.
//

import Foundation
import Cloudinary

class CloudinaryHelper {
    static let shared = CloudinaryHelper()

    var cloudinary: CLDCloudinary

    init() {
        cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "mobiledemoapp", secure: true))
    }
}
