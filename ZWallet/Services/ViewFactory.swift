//
//  ViewFactory.swift
//  ZWallet
//
//  Created by loj on 08.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


//internal struct StoryboardScene {
//    var storyboardName: String
//    var sceneName: String
//}
//
//internal enum Views {
//    case onboarding
//}

internal protocol ViewFactoryProtocol {
    func getOnboardingMainView() -> MainVC
    func getPinView() -> PinVC
    func getPassphraseView() -> PassphraseVC
    func getHomeView() -> HomeVC
    func getTrxDetailsView() -> TrxDetailsVC
    func getRecipientAddressView() -> RecipientAddressVC
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

    private func view<T>(withName viewName: String, onStoryboard storyboardName: String) -> T {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewName) as! T
        return vc
    }
}
