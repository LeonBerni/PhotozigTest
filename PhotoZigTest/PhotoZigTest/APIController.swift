//
//  APIController.swift
//  PhotoZigTest
//
//  Created by Leon Berni on 01/12/17.
//  Copyright © 2017 Leon Berni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class APIController: NSObject {
    
    func getPepblastData(completion: @escaping (JSON) -> ()) -> () {
        let url = "http://pbmedia.pepblast.com/pz_challenge/assets.json"
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.result.value!)
                completion(swiftyJsonVar)
                break
                
            case .failure:
                print("Failed getting data")
                completion(JSON())
                break
                
            }
        }
    }
    
    func getImg(im: String?, cell: PepBlastTableViewCell) -> () {
        let urlAsset = UserDefaults.standard.value(forKey: "assetsLocation") as? String
        let url = String(format: "%@/%@", urlAsset!,im!)
        
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                cell.backgroundImageView.image = image
            }
        }
    }
    
    func downloadVideo(url: URL, filename: String, completion: @escaping (URL) -> ()) -> (){
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        Alamofire.download(
            url,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
                print(progress.completedUnitCount)
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
                print(DefaultDownloadResponse.destinationURL ?? "")
                completion(DefaultDownloadResponse.destinationURL!)
                
            })
    }
    
}
