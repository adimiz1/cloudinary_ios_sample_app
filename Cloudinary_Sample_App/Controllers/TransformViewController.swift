//
//  TransformViewController.swift
//  iOS_Geekle_Conference
//
//  Created by Adi Mizrahi on 12/09/2023.
//

import Foundation
import UIKit
import Cloudinary

class TransformViewController: UIViewController {

    @IBOutlet weak var cvMain: UICollectionView!
    
    @IBOutlet weak var vwContainer: UIView!
    var collectionController: TransformCollectionController!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCollectionView()
        setContainerView(.SmartCropping)
    }

    private func setContainerView(_ type: TransformContainerType) {
        switch type {
        case .SmartCropping:
            let currentController = UIStoryboard(name: "SmartCropping", bundle: nil).instantiateViewController(identifier: "SmartCroppingController")
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
        case .TextLayer:
            let currentController = UIStoryboard(name: "RevealImage", bundle: nil).instantiateViewController(identifier: "RevealImageController") as! RevealImageController
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
            currentController.setMainImageView(rightImage: UIImage(named: "bag"), leftImage: UIImage(named: "bag"))
        case .BackgroundRemoval:
            let currentController = UIStoryboard(name: "RevealImage", bundle: nil).instantiateViewController(identifier: "RevealImageController") as! RevealImageController
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
            currentController.setMainImageView(rightImage: UIImage(named: "sofa"), leftImage: UIImage(named: "sofa"))
        case .ReColor:
            let currentController = UIStoryboard(name: "RevealImage", bundle: nil).instantiateViewController(identifier: "RevealImageController") as! RevealImageController
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
            currentController.setMainImageView(rightImage: UIImage(named: "lady"), leftImage: UIImage(named: "lady"))
        default:
            break
        }
    }

    private func setCollectionView() {
        collectionController = TransformCollectionController(self)
        cvMain.delegate = collectionController
        cvMain.dataSource = collectionController

        let flow = cvMain.collectionViewLayout as! UICollectionViewFlowLayout

            let itemSpacing: CGFloat = 10
            let itemsInOneLine: CGFloat = 10
            flow.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
            let width = UIScreen.main.bounds.size.width - itemSpacing * CGFloat(itemsInOneLine - 1)
            flow.itemSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
            flow.minimumInteritemSpacing = 10
            flow.minimumLineSpacing = itemSpacing
    }
}
extension TransformViewController: TransformCollectionDelegate {
    func cellSelected(_ index: Int) {
        switch index {
        case 0:
            setContainerView(.SmartCropping)
        case 1:
            setContainerView(.TextLayer)
        case 2:
            setContainerView(.BackgroundRemoval)
        case 3:
            setContainerView(.ReColor)
        default:
            break
        }

        cvMain.reloadData()
    }
}


enum TransformContainerType {
    case SmartCropping
    case TextLayer
    case BackgroundRemoval
    case ReColor
}
