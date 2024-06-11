//
//  ImageScrollViewController.swift
//  PersonBioGraphy
//
//  Created by devang bhavsar on 02/04/23.
//

import UIKit
import FSPagerView
class ImageScrollViewController: UIViewController {
    @IBOutlet weak var pagerView: FSPagerView!
    var arrImage = [ImageData]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpPagerView()
    }
    
    func setUpPagerView() {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 5.0
        pagerView.decelerationDistance = 2
        pagerView.interitemSpacing = 10
        pagerView.transformer = FSPagerViewTransformer(type: .cubic)
        //pagerView.transformer = FSPagerViewTransformer(type: .linear)
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension ImageScrollViewController:FSPagerViewDelegate,FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrImage.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = arrImage[index].image//UIImage(named: arrImageNames[index])
        cell.imageView?.tag = index
        //cell.textLabel?.text = "Select Image"
        //cell.textLabel?.textColor = hexStringToUIColor(hex: "C3714B")
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
       // selectedIndex!(pagerView.tag)
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            self.setUpShareActionForIpad(index: pagerView.tag)
        } else {
            self.setUpShareOption(index: pagerView.tag)
        }
    }
    func setUpShareOption(index:Int) {
        let alertStyle = UIAlertController.Style.actionSheet
        let actionSheetController = UIAlertController (title: "PersonBioGraphy", message: "Are you sure you want to share Image?", preferredStyle: alertStyle)
       
        actionSheetController.popoverPresentationController?.sourceView = self.view
            //Add Save-Action
        actionSheetController.addAction(UIAlertAction(title: "Share Image", style: UIAlertAction.Style.default, handler: { (actionSheetController) -> Void in
            let image = self.arrImage[index].image
            let activityItem: [AnyObject] = [image as AnyObject]

            let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)

            self.present(avc, animated: true, completion: nil)
            }))
        //Add Cancel-Action
    actionSheetController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

            //present actionSheetController
        present(actionSheetController, animated: true, completion: nil)

    }
    
    
    func setUpShareActionForIpad(index:Int) {
        DispatchQueue.main.async {
            let image = self.arrImage[index].image
            let activityItem: [AnyObject] = [image as AnyObject]

            let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
            self.present(avc, animated: true, completion: nil)
            if let popOver = avc.popoverPresentationController {
              popOver.sourceView = self.pagerView
              //popOver.sourceRect =
              //popOver.barButtonItem
            }
        }
       
    }
}

