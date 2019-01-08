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
}


internal class ViewFactory: ViewFactoryProtocol {

    private lazy var mainStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()

    func getOnboardingMainView() -> MainVC {
        let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "Main") as! MainVC
        return vc
    }
}
