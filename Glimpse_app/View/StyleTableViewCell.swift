//
//  StyleTableViewCell.swift
//  ARshirt
//
//  Created by Chong Zhuang Hong on 17/01/2021.
//

import UIKit

class StyleTableViewCell: UITableViewCell {

    @IBOutlet weak var shirtImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
