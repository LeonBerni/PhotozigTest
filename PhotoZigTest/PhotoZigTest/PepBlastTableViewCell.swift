//
//  PepBlastTableViewCell.swift
//  PhotoZigTest
//
//  Created by Leon Berni on 01/12/17.
//  Copyright © 2017 Leon Berni. All rights reserved.
//

import UIKit

class PepBlastTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func downloadFunc(_ sender: Any) {
    }
}
