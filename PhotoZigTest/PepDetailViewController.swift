//
//  PepDetailViewController.swift
//  PhotoZigTest
//
//  Created by Leon Berni on 03/12/17.
//  Copyright © 2017 Leon Berni. All rights reserved.
//

import UIKit
import AVKit
class PepDetailViewController: UIViewController {
    
    
    var pepToShow: PepModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let urlAsset = UserDefaults.standard.value(forKey: "assetsLocation") as? String
        let url = String(format: "%@/%@", urlAsset!,(pepToShow?.assetBg)!)
        
        let player = AVPlayer(url: URL(string: url)!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: kCMTimeZero)
            player.play()
        }
        self.present(playerController, animated: false) {
            player.play()
        }
    }
}
