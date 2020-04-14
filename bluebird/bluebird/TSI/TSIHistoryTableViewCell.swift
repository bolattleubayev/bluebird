//
//  TSIHistoryTableViewCell.swift
//  bluebird
//
//  Created by macbook on 2/6/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class TSIHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completionIndicator: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
