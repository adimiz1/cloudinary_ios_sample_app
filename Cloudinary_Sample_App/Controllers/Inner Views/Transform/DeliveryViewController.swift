//
//  DeliveryViewController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 28/12/2023.
//

import Foundation
import UIKit

class DeliveryViewController: UIViewController {
    @IBOutlet weak var vwOptimization: UIView!
    @IBOutlet weak var vwTransform: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var cvTransformation: UICollectionView!
    @IBOutlet weak var cvUseCases: UICollectionView!
    
    var transfromationCollectionController: DeliveryTransformCollectionController!
    var useCasesCollectionController: DeliveryUseCasesCollectionController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setOptimizationView()
        setTransformView()
        setTransformationCollectionView()
        setUseCasesCollectionView()
    }

    private func setOptimizationView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optimizationClicked))
        vwOptimization.addGestureRecognizer(tapGesture)
    }

    private func setTransformView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transformClicked))
        vwTransform.addGestureRecognizer(tapGesture)
    }

    @objc private func optimizationClicked() {
        if let controller = UIStoryboard(name: "Base", bundle: nil).instantiateViewController(identifier: "BaseViewController") as? BaseViewController {
            controller.type = .Optimization
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }

    @objc private func transformClicked() {
        if let controller = UIStoryboard(name: "Base", bundle: nil).instantiateViewController(identifier: "BaseViewController") as? BaseViewController {
            controller.type = .Transform
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }

    private func setTransformationCollectionView() {
        transfromationCollectionController = DeliveryTransformCollectionController()
        cvTransformation.dataSource = transfromationCollectionController
        cvTransformation.delegate = transfromationCollectionController
    }

    private func setUseCasesCollectionView() {
        useCasesCollectionController = DeliveryUseCasesCollectionController()
        cvUseCases.delegate = useCasesCollectionController
        cvUseCases.dataSource = useCasesCollectionController
    }
}
