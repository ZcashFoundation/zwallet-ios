//
//  AmountVC.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class MemoVC: UIViewController {

    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var nextButton: ZWButton!

    public weak var delegate: MemoVCDelegate?
    public weak var localizer: Localizable?
    public var memo: String?

    @IBAction func nextButtonTouched() {
        self.delegate?.memoVCDelegateNextButtonTouched(sender: self, memo: self.memoTextField.text)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.memoTextField.resignFirstResponder()
    }

    private func setup() {
        self.memoTextField.addTarget(self,
                                     action: #selector(memoTextFieldDidChange(_:)),
                                     for: .editingChanged)
    }

    private func updateView() {
        self.memoTextField.becomeFirstResponder()
        
        guard let localizer = self.localizer else { return }

        self.titleLabel.text = localizer.localized("memo.title")
        self.memoTextField.text = self.memo
        self.memoTextField.placeholder = localizer.localized("memo.memo.placeholder")
        self.nextButton.setTitle(localizer.localized("memo.next"), for: .normal)
    }

    @objc
    private func memoTextFieldDidChange(_ sender: Any) {
        self.memo = self.memoTextField.text

        if let memo = self.memo {
            print(memo)
        }
    }
}
