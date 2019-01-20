//
//  HomeTrxTableViewCell.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class HomeTrxTableViewCell: UITableViewCell {

    @IBOutlet weak var directionImageView: UIImageView!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var trxDateLabel: UILabel!
    @IBOutlet weak var trxAmountLabel: UILabel!
    @IBOutlet weak var trxFiatAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
