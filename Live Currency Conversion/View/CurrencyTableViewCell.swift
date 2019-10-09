//
//  CurrencyTableViewCell.swift
//  Live Currency Conversion
//
//  Created by Khaled Fakharany on 10/10/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var valueTxtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
