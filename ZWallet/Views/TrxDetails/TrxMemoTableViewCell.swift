//
//  TrxMemoTableViewCell.swift
//  ZWallet
//
//  Created by loj on 22.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class TrxMemoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
