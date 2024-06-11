//
//  MBProgressHub.swift
//  PersonBioGraphy
//
//  Created by devang bhavsar on 03/04/23.
//

import UIKit
import Foundation
import MBProgressHUD
final class MBProgressHub: NSObject {
    static var objShared = MBProgressHub()
    let imageViewAnimatedGif = UIImageView()
    var arrImage = [UIImage]()
     private override init() {
     }
//    func showProgressHub(view:UIView) {
//        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
//        loadingNotification.mode = MBProgressHUDMode.indeterminate
//        loadingNotification.label.text = "Loading"
//    }
//    func hideProgressHub(view:UIView){
//        MBProgressHUD.hide(for: view, animated: true)
//    }
    func setUpImages()  {
        arrImage.removeAll()
        for i in 0...144 {
            arrImage.append(UIImage(named: "loader-\(i)")!)
        }
    }
    public class func showLoadingSpinner(_ message: String? = "", sender: UIView) -> Void {
        let  HUD = MBProgressHUD.showAdded(to: sender, animated: true)
        HUD.label.text = message
        HUD.bezelView.color = UIColor.clear
        
        MBProgressHub.objShared.imageViewAnimatedGif.animationImages = MBProgressHub.objShared.arrImage
        MBProgressHub.objShared.imageViewAnimatedGif.animationRepeatCount = 1
        MBProgressHub.objShared.imageViewAnimatedGif.animationDuration = 1.0
        MBProgressHub.objShared.imageViewAnimatedGif.startAnimating()
        HUD.customView = MBProgressHub.objShared.imageViewAnimatedGif
        HUD.mode = MBProgressHUDMode.customView
       // Change hud bezelview Color and blurr effect
        HUD.bezelView.color = UIColor.clear
        HUD.bezelView.tintColor = UIColor.clear
        HUD.bezelView.style = .solidColor
        HUD.bezelView.blurEffectStyle = .dark
        HUD.show(animated: true)
    }

    public class func dismissLoadingSpinner(_ sender: UIView) -> Void {
        MBProgressHub.objShared.imageViewAnimatedGif.stopAnimating()
        MBProgressHUD.hide(for: sender, animated: true)
    }
}
