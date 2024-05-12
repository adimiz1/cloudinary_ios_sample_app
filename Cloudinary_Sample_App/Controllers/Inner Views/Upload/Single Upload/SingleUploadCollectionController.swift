//
//  SingleUploadCollectionController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 12/05/2024.
//

import Foundation
import UIKit
import Cloudinary

class SingleUploadCollectionController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    var data: [AssetItems]
    let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: CloudinaryHelper.shared.getUploadCloud()!))
    weak var collectionView: UICollectionView? // Weak reference to collection view

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.data = CoreDataHelper.shared.fetchData() ?? []
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uploadCell", for: indexPath) as! SingleUploadCell
        cell.ivMain.cldSetImage(data[indexPath.row].url, cloudinary: cloudinary)
        return cell
    }

    func refreshData() {
        let newData = CoreDataHelper.shared.fetchData() ?? []
        let oldData = data
        data = newData // Update data

        // Compute changes
        var insertions: [IndexPath] = []
        var deletions: [IndexPath] = []
        var moves: [(from: IndexPath, to: IndexPath)] = []

        // Find insertions and deletions
        for (index, newItem) in newData.enumerated() {
            if let oldIndex = oldData.firstIndex(where: { $0.id == newItem.id }) {
                if index != oldIndex {
                    moves.append((from: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: index, section: 0)))
                }
            } else {
                insertions.append(IndexPath(item: index, section: 0))
            }
        }

        for (index, oldItem) in oldData.enumerated() {
            if !newData.contains(where: { $0.id == oldItem.id }) {
                deletions.append(IndexPath(item: index, section: 0))
            }
        }

        // Apply changes to collection view
        collectionView?.performBatchUpdates({
            if !insertions.isEmpty {
                collectionView?.insertItems(at: insertions)
            }
            if !deletions.isEmpty {
                collectionView?.deleteItems(at: deletions)
            }
            for move in moves {
                collectionView?.moveItem(at: move.from, to: move.to)
            }
        }, completion: nil)
    }
}
