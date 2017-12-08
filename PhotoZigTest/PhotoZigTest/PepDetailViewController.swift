//
//  PepDetailViewController.swift
//  PhotoZigTest
//
//  Created by Leon Berni on 03/12/17.
//  Copyright © 2017 Leon Berni. All rights reserved.
//

import UIKit
import AVKit
class PepDetailViewController: AVPlayerViewController {
    
    
    var pepToShow: PepModel?
    var player2 = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let urlAsset = UserDefaults.standard.value(forKey: "assetsLocation") as? String
        let url = String(format: "%@/%@", urlAsset!,(pepToShow?.assetBg)!)
        let aurl = String(format: "%@/%@", urlAsset!,(pepToShow?.assetSg)!)
        let apiController = APIController()
        apiController.downloadVideo(url: URL(string: url)!, filename: (pepToShow?.assetBg)!) { (videoURL) in
            self.playVideo(videoURL: videoURL)
            self.playAudio(audioURL: aurl)
        }
        
//        playVideo(videoURL: url)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func playVideo(videoURL: URL) -> () {
        let player = AVPlayer(url: videoURL)
        self.player = player
        self.player?.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: kCMTimeZero)
            player.play()
        }
    }
    
    func playAudio(audioURL: String) -> () {
            let player = AVPlayer(url: URL(string: audioURL)!)
            self.player2 = player;
            self.player2.volume = 1.0
            self.player2.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player2.currentItem, queue: .main) { _ in
            NotificationCenter.default.removeObserver(self)
            self.player?.pause()
        }
    }
}
