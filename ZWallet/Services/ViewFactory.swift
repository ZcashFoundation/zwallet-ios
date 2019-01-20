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
}


internal class ViewFactory: ViewFactoryProtocol {

    private lazy var mainStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()

    private lazy var pinStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Pin", bundle: nil)
    }()

    private lazy var passphraseStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Passphrase", bundle: nil)
    }()

    private lazy var homeStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Home", bundle: nil)
    }()

    func getOnboardingMainView() -> MainVC {
        let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "Main") as! MainVC
        return vc
    }

    func getPinView() -> PinVC {
        let vc = self.pinStoryboard.instantiateViewController(withIdentifier: "Pin") as! PinVC
        return vc
    }

    func getPassphraseView() -> PassphraseVC {
        let vc = self.passphraseStoryboard.instantiateViewController(withIdentifier: "Passphrase") as! PassphraseVC
        return vc
    }

    func getHomeView() -> HomeVC {
        let vc = self.homeStoryboard.instantiateViewController(withIdentifier: "Home") as! HomeVC
        return vc
    }
}
