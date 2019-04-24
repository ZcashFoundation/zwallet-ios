//
//  QrcVC.swift
//  ZWallet
//
//  Created by loj on 24.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class QrcVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var qrcImageView: UIImageView!
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var copyButton: ZWButton!

    public weak var delegate: QrcVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: QrcVCViewModel?

    @IBAction func copyButtonTouched() {
        self.delegate?.qrcVCDelegateCopyButtonTouched(sender: self, address: viewModel?.walletAddress)
    }

    @IBAction func backButtonTouched() {
        self.delegate?.qrcVCDelegateBackButtonTouched(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    private func setup() {
        if let localizer = self.localizer {
            self.titleLabel.text = localizer.localized("qrc.title")
            self.backButton.setTitle(localizer.localized("qrc.button.copy"), for: .normal)
        }

        if let viewModel = self.viewModel {
            self.walletAddressLabel.text = viewModel.walletAddress
            self.qrcImageView.image = viewModel.qrcImage
        }
    }
}
