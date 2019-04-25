//
//  SettingsCoordinator.swift
//  ZWallet
//
//  Created by loj on 25.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class SettingsCoordinator: BaseCoordinator {

    internal weak var delegate: SettingsCoordinatorDelegate?

    private var iocContainer: IocContainerProtocol

    private var viewFactory: ViewFactoryProtocol
    private var localizer: Localizable

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer

        self.viewFactory = self.iocContainer.viewFactory
        self.localizer = self.iocContainer.localizer

        super.init(navigationController: navigationController)
    }

    internal func start() {
        self.showSettingsView()
    }
}


extension SettingsCoordinator: SettingsVCDelegate {
    func settingsVCDelegateBackTouched(sender: SettingsVC) {
        self.delegate?.settingsCoordinatorDelegateBackTouched(coordinator: self)
    }

    func settingsVCDelegateNukeWalletTouched(sender: SettingsVC) {
        #warning("implement")
    }

    private func showSettingsView() {
        let vc = self.viewFactory.getSettingsVC()
        vc.delegate = self
        vc.localizer = self.localizer
        self.navigationController.pushViewController(vc, animated: true)
    }
}
