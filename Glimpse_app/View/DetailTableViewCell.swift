//
//  DetailTableViewCell.swift
//  ARshirt
//
//  Created by Chong Zhuang Hong on 17/01/2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleEnglish: UILabel!
    
    @IBOutlet weak var titleJapanese: UILabel!
    
    @IBOutlet weak var sceneImage: UIImageView!
    
    @IBOutlet weak var lock: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
