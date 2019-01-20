//
//  HomeCoordinator.swift
//  ZWallet
//
//  Created by loj on 20.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation
import UIKit


internal class HomeCoordinator: BaseCoordinator {

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
        self.showHomeView()
    }
}


extension HomeCoordinator: HomeVCDelegate {
    func homeVCSendButtonTouched(sender: HomeVC) {
        #warning("implement")
    }

    func homeVCReceiveButtonTouched(sender: HomeVC) {
        #warning("implement")
    }

    func homeVCSettingsButtonTouched(sender: HomeVC) {
        #warning("implement")
    }

    func homeVCTrxCellTouched(sender: HomeVC) {
        #warning("implement")
    }

    private func showHomeView() {
        let vc = self.viewFactory.getHomeView()
        vc.localizer = self.localizer
        self.navigationController.pushViewController(vc, animated: true)
    }
}
