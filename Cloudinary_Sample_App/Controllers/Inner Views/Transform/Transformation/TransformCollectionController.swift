import Foundation
import UIKit
import Cloudinary

protocol TransformCollectionDelegate: AnyObject {
    func cellSelected(_ index: Int)
}

class TransformCollectionController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: TransformCollectionDelegate?
    var selectedCellIndex: Int?
    var previousSelectedCell: TransformCollectionCell?

    init(delegate: TransformCollectionDelegate) {
        self.delegate = delegate
        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransformCollectionCell", for: indexPath) as! TransformCollectionCell
        cell.setCellBy(index: indexPath.row)
        setSelectedCell(cell, index: indexPath.row)

        // Initialize previousSelectedCell for the first cell
        if indexPath.row == 0 && previousSelectedCell == nil {
            previousSelectedCell = cell
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousSelectedCell = previousSelectedCell {
            setSelectedCell(previousSelectedCell, index: -1) // Deselect previous cell
        }
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? TransformCollectionCell {
            selectedCellIndex = indexPath.row
            setSelectedCell(selectedCell, index: indexPath.row) // Select new cell
            previousSelectedCell = selectedCell
        }
        selectedCellIndex = indexPath.row
        delegate?.cellSelected(indexPath.row)
    }

    func setSelectedCell(_ cell: TransformCollectionCell, index: Int) {
        if index == selectedCellIndex {
            cell.layer.borderColor = UIColor(named: "primary")?.cgColor
            cell.layer.borderWidth = 3
            cell.layer.cornerRadius = 4
        } else {
            cell.layer.borderWidth = 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: 116)
    }
}
