//
//  DeliveryTransformCollectionController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 30/01/2024.
//

import Foundation
import UIKit

class DeliveryTransformCollectionController: NSObject,  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "transfromationCell", for: indexPath) as! TransformationCell
        switch indexPath.row {
        case 0:
            cell.setMainImageView(UIImage(named: "delivery-smart_crop"))
        case 1:
            cell.setMainImageView(UIImage(named: "delivery-layer_image"))
        default:
            break
        }
        return cell
    }


}
