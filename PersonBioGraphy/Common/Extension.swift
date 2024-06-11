//
//  Extension.swift
//  PersonBioGraphy
//
//  Created by devang bhavsar on 01/04/23.
//

import Foundation
import MapKit
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
func setAlertWithCustomAction(viewController:UIViewController,message:String,ok okBlock: @escaping ((Bool) -> Void),isCancel:Bool,cancel cancelBlock: @escaping ((Bool) -> Void)) {
    let alertController = UIAlertController(title: "", message:"", preferredStyle: .alert)
    // Create the actions
    let imageView = UIImageView(frame: CGRect(x: 95, y: -40, width: 80, height: 80))
    imageView.image = UIImage(named:"alertMessage") // Your image here...
    alertController.view.addSubview(imageView)
    //alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = hexStringToUIColor(hex: kTheamColor)
    let newMessage = "\n" + message
    alertController.setValue(NSAttributedString(string: newMessage, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedTitle")
    alertController.view.tintColor = UIColor.white

    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
        UIAlertAction in
        okBlock(true)
    }
    alertController.addAction(okAction)
    if isCancel {
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            cancelBlock(true)
        }
        alertController.addAction(cancelAction)
    }
    viewController.present(alertController, animated: true, completion: nil)
}

func setAlertWithCustomActionOk(viewController:UIViewController,message:String,ok okBlock: @escaping ((Bool) -> Void)) {
    let alertController = UIAlertController(title: "Person Biography", message:message, preferredStyle: .alert)
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        okBlock(true)
    }
    alertController.addAction(okAction)
    viewController.present(alertController, animated: true, completion: nil)
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
extension UIImage {

    func isEqualToImage(_ image: UIImage) -> Bool {
        return self.pngData() == image.pngData()
    }
    
    func mergeImage(image2:UIImage) -> UIImage {
        let topImage = self
        let bottomImage = image2

        let size = CGSize(width: screenWidth, height: topImage.size.height + bottomImage.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        topImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: topImage.size.height))
        bottomImage.draw(in: CGRect(x: 0, y: topImage.size.height, width: size.width, height: bottomImage.size.height))

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        //set finalImage to IBOulet UIImageView
         return newImage
    }

}
