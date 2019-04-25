//
//  ViewFactory.swift
//  ZWallet
//
//  Created by loj on 08.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal protocol ViewFactoryProtocol {
    func getOnboardingMainView() -> MainVC
    func getPinView() -> PinVC
    func getPassphraseView() -> PassphraseVC
    func getHomeView() -> HomeVC
    func getTrxDetailsView() -> TrxDetailsVC
    func getRecipientAddressView() -> RecipientAddressVC
    func getScanView() -> ScanVC
    func getAmountView() -> AmountVC
    func getMemoVC() -> MemoVC
    func getReviewVC() -> ReviewVC
    func getAddressVC() -> AddressVC
    func getQrcVC() -> QrcVC
    func getSettingsVC() -> SettingsVC
}


internal class ViewFactory: ViewFactoryProtocol {

    func getOnboardingMainView() -> MainVC {
        return self.view(withName: "Main", onStoryboard: "Main")
    }

    func getPinView() -> PinVC {
        return self.view(withName: "Pin", onStoryboard: "Pin")
    }

    func getPassphraseView() -> PassphraseVC {
        return self.view(withName: "Passphrase", onStoryboard: "Passphrase")
    }

    func getHomeView() -> HomeVC {
        return self.view(withName: "Home", onStoryboard: "Home")
    }

    func getTrxDetailsView() -> TrxDetailsVC {
        return self.view(withName: "TrxDetails", onStoryboard: "TrxDetails")
    }

    func getRecipientAddressView() -> RecipientAddressVC {
        return self.view(withName: "RecipientAddress", onStoryboard: "RecipientAddress")
    }

    func getScanView() -> ScanVC {
        return self.view(withName: "Scan", onStoryboard: "Scan")
    }

    func getAmountView() -> AmountVC {
        return self.view(withName: "Amount", onStoryboard: "Amount")
    }

    func getMemoVC() -> MemoVC {
        return self.view(withName: "Memo", onStoryboard: "Memo")
    }

    func getReviewVC() -> ReviewVC {
        return self.view(withName: "Review", onStoryboard: "Review")
    }

    func getAddressVC() -> AddressVC {
        return self.view(withName: "Address", onStoryboard: "Address")
    }

    func getQrcVC() -> QrcVC {
        return self.view(withName: "QRC", onStoryboard: "QRC")
    }

    func getSettingsVC() -> SettingsVC {
        return self.view(withName: "Settings", onStoryboard: "Settings")
    }

    private func view<T>(withName viewName: String, onStoryboard storyboardName: String) -> T {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewName) as! T
        return vc
    }
}
