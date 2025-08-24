//
//  SupportTableViewCell.swift
//  Glimpse
//
//  Created by Chong Zhuang Hong on 01/02/2021.
//

import UIKit

class SupportTableViewCell: UITableViewCell {


    @IBOutlet weak var supportImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
