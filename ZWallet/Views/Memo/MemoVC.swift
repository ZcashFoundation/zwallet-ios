//
//  AmountVC.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import UIKit

class MemoVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var progressBar: ZWProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var nextButton: ZWButton!

    public weak var delegate: MemoVCDelegate?
    public weak var localizer: Localizable?
    public var viewModel: MemoVCViewModel?

    @IBAction func nextButtonTouched() {
        let memo = self.memoTextField.text
        guard let mode = self.viewModel?.mode else { return }

        #warning("have only one callback method, provide mode, coordinator must decide")
       switch mode {
        case .new:
            self.delegate?.memoVCDelegateNextButtonTouched(sender: self, memo: memo)
        case .edit(_):
            self.delegate?.memoVCDelegateDoneButtonTouched(sender: self, memo: memo)
        }
    }

    @IBAction func backButtonTouched() {
        self.delegate?.memoVCDelegateBackTouched(sender: self)
    }

    @IBAction func cancelTouched() {
        self.delegate?.memoVCDelegateCancelTouched(sender: self)
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

        self.memoTextField.placeholder = localizer.localized("memo.memo.placeholder")

        if let mode = self.viewModel?.mode {
            switch mode {
            case .new(let initialMemo):
                self.titleLabel.text = localizer.localized("memo.title")
                self.memoTextField.text = initialMemo
                self.nextButton.setTitle(localizer.localized("memo.next"), for: .normal)
                self.backButton.isHidden = false
                self.progressBar.isHidden = false
            case .edit(let memo):
                self.titleLabel.text = localizer.localized("memo.title.edit")
                self.memoTextField.text = memo
                self.nextButton.setTitle(localizer.localized("global.done"), for: .normal)
                self.backButton.isHidden = true
                self.progressBar.isHidden = true
            }
        }
    }

    @objc
    private func memoTextFieldDidChange(_ sender: Any) {
        #warning("how long does a memo allowed to be?")
    }
}
