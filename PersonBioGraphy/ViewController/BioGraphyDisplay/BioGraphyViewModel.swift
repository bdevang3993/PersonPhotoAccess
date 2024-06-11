//
//  BioGraphyViewModel.swift
//  Squat
//
//  Created by devang bhavsar on 19/03/22.
//

import UIKit
class BioGraphyViewModel: NSObject {
 //   var headerViewXib:CommanView?
 //   var objBioGraphyDetail = BioGraphyDetail()
    var arrBiographyData = [BiographyData]()
    var arrImage = [ImageData]()
    var arrFilterImage = [ImageData]()
    var arrCityName = [String]()
    func setUpData(var wheelView:ALRadialMenu) {
        print("images = \(arrImage)")
        for value in arrImage {
            arrCityName.append(value.cityName)
           // arrBiographyData.append(data)
        }
        let cityName = arrCityName.removeDuplicates()
        for value in cityName {
            let glovoView = GlovoItem.init(image: UIImage(named: "splashIcon")!, text: value)
            items.append(glovoView)
        }
        print("arrCity = \(cityName)")
        wheelView.generateButtons(items: items, centerItem:nil)
    }
}
