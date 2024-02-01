//
//  VideoFeedCollectionController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 31/01/2024.
//

import Foundation
import UIKit

class VideoFeedCollectionController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoFeedCell", for: indexPath) as! VideoFeedCell
        cell.setImage(indexPath.row)
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = false
        cell.contentView.layer.cornerRadius = 4
        cell.contentView.layer.masksToBounds = false
        return cell
    }
    

}
