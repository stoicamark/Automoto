//
//  CoffeeCell.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 10..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import UIKit

class CoffeeCell: UITableViewCell {

    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
