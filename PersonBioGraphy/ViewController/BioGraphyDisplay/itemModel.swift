//
//  itemModel.swift
//  Squat
//
//  Created by devang bhavsar on 19/03/22.
//

import Foundation
import UIKit
import MapKit
var items = [GlovoItem]()

struct BiographyData {
    var personPlaceName: String
    var personDescription: String
    var personImage: UIImage
}
struct ImageData{
    var image:UIImage
    var coordinator:CLLocationCoordinate2D
    var cityName:String
    
}
