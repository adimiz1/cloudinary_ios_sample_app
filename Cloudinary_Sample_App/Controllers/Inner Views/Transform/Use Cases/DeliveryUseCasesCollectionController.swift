//
//  DeliveryUseCasesCollectionController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 30/01/2024.
//

import Foundation
import UIKit

class DeliveryUseCasesCollectionController: NSObject,  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "useCaseCell", for: indexPath) as! UseCaseCell
        cell.setCellBy(index: indexPath.row)
        return cell
    }
    

}
