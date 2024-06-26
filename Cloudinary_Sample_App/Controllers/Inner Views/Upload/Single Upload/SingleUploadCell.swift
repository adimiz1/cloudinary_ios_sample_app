//
//  SignUploadCell.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 12/05/2024.
//

import Foundation
import UIKit
import Cloudinary
class SingleUploadCell: UICollectionViewCell {
    @IBOutlet weak var ivMain: CLDUIImageView!

    func setImage(_ url: String, _ cloudinary: CLDCloudinary) {
        var url = url
        if url.contains("video") {
            url = replaceExtension(urlString: url) ?? ""
            ivMain.cldSetImage(url, cloudinary: cloudinary)
            return
        }
        guard let url = URL(string: url) else {
            return
        }
        let publicId = url.lastPathComponent
        ivMain.cldSetImage(publicId: publicId, cloudinary: cloudinary, transformation: CLDTransformation().setCrop("thumb"))
    }

    func replaceExtension(urlString: String) -> String? {
        guard let url = URL(string: urlString) else {
            return nil // Invalid URL
        }

        // Get the last path component
        let lastPathComponent = url.lastPathComponent

        // Get the path extension
        let pathExtension = (lastPathComponent as NSString).pathExtension

        // Replace the path extension with ".jpg"
        let newLastPathComponent = (lastPathComponent as NSString).deletingPathExtension + ".jpg"

        // Create a new URL instance with the updated path component
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.path = urlComponents.path.replacingOccurrences(of: lastPathComponent, with: newLastPathComponent)

            // Get the updated URL string
            if let updatedURLString = urlComponents.string {
                return updatedURLString
            }
        }

        return urlString // Return original URL if there's any failure in updating the URL string
    }
}
