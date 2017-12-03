//
//  PepModel.swift
//  PhotoZigTest
//
//  Created by Leon Berni on 02/12/17.
//  Copyright © 2017 Leon Berni. All rights reserved.
//

import UIKit
import SwiftyJSON

class PepModel: NSObject {
    var assetLocation: String?
    var assetName: String?
    var assetBg: String?
    var assetIm: String?
    var assetSg: String?
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        self.assetName = json["name"].stringValue
        self.assetBg = json["bg"].stringValue
        self.assetIm = json["im"].stringValue
        self.assetSg = json["sg"].stringValue
    }
    
}
