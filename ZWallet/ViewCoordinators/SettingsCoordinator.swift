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
    private var propertyStore: PropertyStoreProtocol

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer

        self.viewFactory = self.iocContainer.viewFactory
        self.localizer = self.iocContainer.localizer
        self.propertyStore = self.iocContainer.propertyStore

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

    func settingsVCDelegateLanguageSelectionTouched(sender: SettingsVC) {
        let vc = self.viewFactory.getLanguageVC()


        self.navigationController.pushViewController(vc, animated: true)
    }

    func settingsVCDelegateFiatSelectionTouched(sender: SettingsVC) {
        self.showFiatView()
    }

    func settingsVCDelegateNodeSelectionTouched(sender: SettingsVC) {

    }

    func settingsVCDelegateBiometricSwitchTouched(sender: SettingsVC) {

    }

    func settingsVCDelegateResetPinTouched(sender: SettingsVC) {

    }

    func settingsVCDelegateDisplayPassphraseTouched(sender: SettingsVC) {
        
    }

    private func showSettingsView() {
        let vc = self.viewFactory.getSettingsVC()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.viewModel = SettingsVCViewModel(currency: self.propertyStore.currency,
                                           language: self.propertyStore.language,
                                           nodeAddress: self.propertyStore.nodeAddress)
        self.navigationController.pushViewController(vc, animated: true)
    }
}


extension SettingsCoordinator: FiatVCDelegate {

    func fiatVCDelegateBackTouched(sender: FiatVC) {
        self.navigationController.popViewController(animated: true)
    }

    func fiatVCDelegateCellTouched(sender: FiatVC) {
        
    }

    private func showFiatView() {
        let vc = self.viewFactory.getFiatVC()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.viewModel = FiatVCViewModel(currencies: Constants.currencies)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
