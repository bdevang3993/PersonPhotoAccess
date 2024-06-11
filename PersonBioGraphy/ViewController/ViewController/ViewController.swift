//
//  ViewController.swift
//  PersonBioGraphy
//
//  Created by devang bhavsar on 25/03/23.
//

import UIKit
import Photos
class ViewController: UIViewController {
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var btnPrivacy: UIButton!
    var arrImages = [ImageData]()
    var allPhotos : PHFetchResult<PHAsset>? = nil
    @IBOutlet weak var btnSkip: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnPrivacy.setTitle("", for: .normal)
        let userDefault = UserDefaults.standard
        if let data = userDefault.value(forKey: "privacyPolicy") {
            if data as! Bool {
                imgChecked.image = UIImage(named: "checked")
            }
        }
       
    }

    @IBAction func btnSkipClicked(_ sender: Any) {
        let newimage = UIImage(named: "unChecked")
        if (newimage!.isEqualToImage(imgChecked.image!))  {
            setAlertWithCustomAction(viewController: self, message: "please checked Term and Privacy Policy", ok: { isSuccess in
            }, isCancel: false) { isFalied in
            }
            return
        }
        if InternetConnectionManager.isConnectedToNetwork(){
            self.fetchAllPhoto()
        }else{
            setAlertWithCustomActionOk(viewController: self, message: "please check internet connection") { isOk in
            }
        }
        
    }
    
    @IBAction func btnPrivacyClicked(_ sender: Any) {
//        if let url = URL(string: "https://doc-hosting.flycricket.io/personbiography/a266bab8-6376-4b85-ad08-60696eea9dcd/privacy") {
//            UIApplication.shared.open(url)
            imgChecked.image = UIImage(named: "checked")
            let userDefault = UserDefaults.standard
            userDefault.set(true, forKey: "privacyPolicy")
        let objPrivacyPolicy = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        objPrivacyPolicy.modalPresentationStyle = .overFullScreen
        self.present(objPrivacyPolicy, animated: true)
      //   }
    }
    
    func moveToNext() {
        DispatchQueue.main.async { [self] in
            MBProgressHub.dismissLoadingSpinner(self.view)
            let objNext = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BioGraphyDisplayViewController") as? BioGraphyDisplayViewController
            objNext?.objBioGraphyDisplayViewModel.arrImage = arrImages
            self.navigationController?.pushViewController(objNext!, animated: true)
        }
       
    }
    func fetchAllPhoto() {
        DispatchQueue.main.async {
            MBProgressHub.showLoadingSpinner(sender: self.view)
        }
        
        PHPhotoLibrary.requestAuthorization { [self] (status) in
                switch status {
                case .authorized:
                    print("Good to proceed")
                    let fetchOptions = PHFetchOptions()
                    self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    for i in 0...self.allPhotos!.count - 1 {
                        self.getAssetThumbnail(asset: allPhotos![i])
                    }
//                    DispatchQueue.main.async {
//                        MBProgressHub.dismissLoadingSpinner(self.view)
//                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        // Put your code which should be executed with a delay here
                        self.moveToNext()
                        
                    }
                case .denied, .restricted:
                    DispatchQueue.main.async {
                        MBProgressHub.dismissLoadingSpinner(self.view)
                    }
                    print("Not allowed")
                case .notDetermined:
                    DispatchQueue.main.async {
                        MBProgressHub.dismissLoadingSpinner(self.view)
                    }
                    print("Not determined yet")
                case .limited:
                    print("limited")
                    DispatchQueue.main.async {
                        MBProgressHub.dismissLoadingSpinner(self.view)
                    }
                @unknown default:
                    print("limited")
                    DispatchQueue.main.async {
                        MBProgressHub.dismissLoadingSpinner(self.view)
                    }
                }
            }
    }
    func getAssetThumbnail(asset: PHAsset)  {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        print("location = \(asset.location?.coordinate)")
        if asset.location?.coordinate != nil {
            let location = CLLocation(latitude: (asset.location?.coordinate.latitude)!, longitude: (asset.location?.coordinate.longitude)!)
            location.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                print(city + ", " + country)  // Rio de Janeiro, Brazil
                let data = ImageData(image: thumbnail, coordinator: asset.location!.coordinate, cityName: city)
                self.arrImages.append(data)
            }
        }
        
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 512.0, height: 512.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result ?? UIImage()
        })
    }
}

