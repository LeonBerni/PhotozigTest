//
//  ViewController.swift
//  PhotoZigTest
//
//  Created by Leon Berni on 30/11/17.
//  Copyright © 2017 Leon Berni. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    let apiControllerInstance = APIController.init()
    var peps: [PepModel]? = [PepModel]()
    var pepJson = JSON()
    var pepToSend: PepModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        apiControllerInstance.getPepblastData(completion: { pepJson in
            self.pepJson = pepJson;
            UserDefaults.standard.set(self.pepJson["assetsLocation"].stringValue, forKey: "assetsLocation")
            for pep in self.pepJson["objects"] {
                let pepToAdd = PepModel(json: pep.1)
                self.peps?.append(pepToAdd)
            }
            self.tableview.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! PepDetailViewController
        detailVC.pepToShow = pepToSend
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pepToSend = peps?[indexPath.row]
        self.performSegue(withIdentifier: "pepSegue", sender: self);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.peps != nil) {
            return (self.peps?.count)!
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "pepCell") as! PepBlastTableViewCell
        cell.nameLbl.text = self.peps![indexPath.row].assetName
        apiControllerInstance.getImg(im: self.peps![indexPath.row].assetIm, cell: cell)
        return cell
    }
    
    
    
}
