//
//  PrivacyPolicyViewController.swift
//  PersonBioGraphy
//
//  Created by devang bhavsar on 10/04/23.
//

import UIKit
import WebKit
class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var webviewPrivacy: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let web_url = URL(string:"https://doc-hosting.flycricket.io/personbiography/a266bab8-6376-4b85-ad08-60696eea9dcd/privacy")!
         let web_request = URLRequest(url: web_url)
        webviewPrivacy.load(web_request)
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.dismiss(animated: true)
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
