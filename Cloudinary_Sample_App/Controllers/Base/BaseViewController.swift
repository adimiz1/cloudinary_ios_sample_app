//
//  BaseViewController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 04/01/2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vwBack: UIView!
    var type: BaseControllerType!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitle()
        setController()
        setBackButton()
    }

    private func setBackButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backClicked))
        vwBack.addGestureRecognizer(tapGesture)
    }

    private func setTitle() {
        switch type {
        case .Optimization:
            lbTitle.text = "Optimization"
            break
        case .Transform:
            lbTitle.text = "Transform"
            break
        case .Upload:
            lbTitle.text = "Upload"
            break
        case .UploadLarge:
            lbTitle.text = "Upload Large"
            break
        case .UploadWidget:
            lbTitle.text = "Upload Widget"
            break
        case .ImageWidget:
            lbTitle.text = "Image Widget"
            break
        case .none:
            break
        }
    }

    private func setController() {
        switch type {
        case .Optimization:
            let currentController = UIStoryboard(name: "Optimization", bundle: nil).instantiateViewController(identifier: "OptimizationViewController")
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
        case .Transform:
            let currentController = UIStoryboard(name: "Transform", bundle: nil).instantiateViewController(identifier: "TransformViewController")
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
        case .Upload:
            let currentController = (UIStoryboard(name: "UploadChoice", bundle: nil).instantiateViewController(identifier: "UploadChoiceController") as! UploadChoiceController)
            currentController.view.frame = vwContainer.bounds
            currentController.type = .Upload
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
        case .UploadLarge:
            let currentController = (UIStoryboard(name: "UploadChoice", bundle: nil).instantiateViewController(identifier: "UploadChoiceController") as! UploadChoiceController)
            currentController.view.frame = vwContainer.bounds
            currentController.type = .UploadLarge
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
        case .UploadWidget:
            let currentController = UIStoryboard(name: "UploadWidget", bundle: nil).instantiateViewController(identifier: "UploadWidgetViewController")
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
        case .ImageWidget:
            let currentController = UIStoryboard(name: "ImageWidget", bundle: nil).instantiateViewController(identifier: "ImageWidgetViewController")
            currentController.view.frame = vwContainer.bounds
            addChild(currentController)
            vwContainer.addSubview(currentController.view)
            currentController.didMove(toParent: self)
            break
        case .none:
            break
        }
    }

    @objc private func backClicked() {
        self.dismiss(animated: true)
    }
}

enum BaseControllerType {
    case Optimization
    case Transform
    case Upload
    case UploadLarge
    case UploadWidget
    case ImageWidget
}
public enum UploadViewType {
    case Upload
    case UploadLarge
}
