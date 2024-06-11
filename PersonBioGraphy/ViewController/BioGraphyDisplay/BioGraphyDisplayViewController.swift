//
//  BioGraphyDisplayViewController.swift
//  Squat
//
//  Created by devang bhavsar on 19/03/22.
//

import UIKit

class BioGraphyDisplayViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var wheelView: ALRadialMenu!
    @IBOutlet weak var bottonView: RoundBottomView!
    var didAppear = false
    var objBioGraphyDisplayViewModel = BioGraphyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            wheelView.presentInView()
    }
    
    func configureData() {
        
        self.wheelView.buttonClickedEvent = {[weak self] result in
            DispatchQueue.main.async {
                print("selected tag = \(result)")
                if result != 100 {
                }
               
            }
        }
        wheelView.didPressButton = { [weak self] (glovoView) in
            print("glovo view = \(glovoView.label.text)")
            if glovoView.label.text != "" {
                let arrNewData = self?.objBioGraphyDisplayViewModel.arrImage.filter{$0.cityName == glovoView.label.text}
                self!.objBioGraphyDisplayViewModel.arrFilterImage = arrNewData!
                print("arrData = \(arrNewData)")
                let objSwipableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageScrollViewController") as! ImageScrollViewController
                objSwipableView.arrImage = self!.objBioGraphyDisplayViewModel.arrFilterImage
                self?.navigationController?.pushViewController(objSwipableView, animated: true)
            }
           // self?.presenter?.navigateToBubbleDetails(item: glovoView)
        }
        wheelView.generateButtons(items: items, centerItem: GlovoItem(image:#imageLiteral(resourceName: "splashIcon"), text: ""))
        objBioGraphyDisplayViewModel.setUpData(var: wheelView)
    }
    
    
    @IBAction func btnInformationClicked(_ sender: Any) {
        let objPrivacyPolicy = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        objPrivacyPolicy.modalPresentationStyle = .overFullScreen
        self.present(objPrivacyPolicy, animated: true)
//        if let url = URL(string: "https://doc-hosting.flycricket.io/personbiography/a266bab8-6376-4b85-ad08-60696eea9dcd/privacy") {
//            UIApplication.shared.open(url)
//        }
    }
    
    
  
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
