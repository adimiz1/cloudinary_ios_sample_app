//
//  WidgetsViewController.swift
//  Cloudinary_Sample_App
//
//  Created by Adi Mizrahi on 25/01/2024.
//

import Foundation
import UIKit

class WidgetsViewController: UIViewController {

    @IBOutlet weak var vwUploadWidget: UIView!
    @IBOutlet weak var vwImageWidget: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUploadWidgetView()
        setImageWidgetView()
    }

    private func setUploadWidgetView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadWidgetClicked))
        vwUploadWidget.addGestureRecognizer(tapGesture)
    }

    private func setImageWidgetView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageWidgetClicked))
        vwImageWidget.addGestureRecognizer(tapGesture)
    }

    @objc private func uploadWidgetClicked() {
        if let controller = UIStoryboard(name: "Base", bundle: nil).instantiateViewController(identifier: "BaseViewController") as? BaseViewController {
            controller.type = .UploadWidget
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }

    @objc private func imageWidgetClicked() {
        if let controller = UIStoryboard(name: "Base", bundle: nil).instantiateViewController(identifier: "BaseViewController") as? BaseViewController {
            controller.type = .ImageWidget
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }
}
