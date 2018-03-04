//
//  ChatTableViewCell.swift
//  ParseChat
//
//  Created by David King on 3/3/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var ChatLabel: UILabel!
    
    @IBOutlet weak var UserLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
