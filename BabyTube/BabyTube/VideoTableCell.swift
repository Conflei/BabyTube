//
//  VideoTableCell.swift
//  BabyTube
//
//  Created by Virtual Castle  on 9/20/18.
//  Copyright © 2018 Virtual Castle . All rights reserved.
//

import UIKit

class VideoTableCell: UITableViewCell {

    @IBOutlet weak var videoImg: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var channel: UILabel!
    @IBOutlet weak var typeVideo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
