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
    private var trxHistoryProvider: TrxHistoryProviderProtocol

    private var homeVC: HomeVC?

    internal init(navigationController: UINavigationController,
                  iocContainer: IocContainerProtocol)
    {
        self.iocContainer = iocContainer

        self.viewFactory = self.iocContainer.viewFactory
        self.localizer = self.iocContainer.localizer
        self.trxHistoryProvider = self.iocContainer.trxHistoryProvider

        super.init(navigationController: navigationController)
    }

    internal func start() {
        self.showHomeView()
    }
}


extension HomeCoordinator: HomeVCDelegate {
    func homeVCSendButtonTouched(sender: HomeVC) {
        self.showSend()
    }

    func homeVCReceiveButtonTouched(sender: HomeVC) {
        #warning("implement")
    }

    func homeVCSettingsButtonTouched(sender: HomeVC) {
        #warning("implement")
    }

    func homeVCTrxCellTouched(sender: HomeVC, rowNumber: Int) {
        let trxDetails = self.trxHistoryProvider.all()[rowNumber]
        self.showTrxDetailsView(for: trxDetails)
    }

    private func showHomeView() {
        #warning("remove")
        self.test_addDummyData()

        self.registerForNewTrx()

        self.homeVC = self.viewFactory.getHomeView()
        if let vc = self.homeVC {
            vc.delegate = self
            vc.localizer = self.localizer
            vc.trxHistory = self.trxHistoryProvider.all()
            self.navigationController.pushViewController(vc, animated: true)
        }
    }

    private func showSend() {
        let sendCoordinator = SendCoordinator(navigationController: self.navigationController,
                                              iocContainer: self.iocContainer)
        self.add(childCoordinator: sendCoordinator)
        sendCoordinator.delegate = self
        sendCoordinator.start()
    }

    private func showTrxDetailsView(for trxDetails: TrxDetails) {
        let vc = self.viewFactory.getTrxDetailsView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.trxDetails = trxDetails
        self.navigationController.pushViewController(vc, animated: true)
    }

    private func registerForNewTrx() {
        self.trxHistoryProvider.register(observer: self)
    }

    private func deregisterFromNewTrx() {
        self.trxHistoryProvider.deregister(observer: self)
    }

    private func test_addDummyData() {
        let trxHistoryProvider = self.iocContainer.trxHistoryProvider

        let detailsSent = TrxDetails(direction: .send,
                                     date: Date.init(),
                                     amount: 22_080_000_000_000_000,
                                     address: "address send to",
                                     trxId: "trx id send",
                                     memo: "memo send")
        let detailsReceived = TrxDetails(direction: .receive,
                                         date: Date.init(),
                                         amount: 22_000_000_000_000,
                                         address: "address received from",
                                         trxId: "trx id receive",
                                         memo: "memo receive")
        trxHistoryProvider.add(trxDetails: detailsSent)
        trxHistoryProvider.add(trxDetails: detailsReceived)
        trxHistoryProvider.add(trxDetails: detailsSent)
        trxHistoryProvider.add(trxDetails: detailsReceived)
        trxHistoryProvider.add(trxDetails: detailsSent)
        trxHistoryProvider.add(trxDetails: detailsReceived)
        trxHistoryProvider.add(trxDetails: detailsSent)
        trxHistoryProvider.add(trxDetails: detailsReceived)
    }
}


extension HomeCoordinator: TrxDetailsVCDelegate {

    func trxDetailsVCDelegateBackTouched(sender: TrxDetailsVC) {
        self.navigationController.popViewController(animated: true)
    }
}


extension HomeCoordinator: TrxHistoryObservable {
    
    func changed() {
        #warning("implement")
    }
}


extension HomeCoordinator: SendCoordinatorDelegate {

    func sendCoordinatorSuccessful(coordinator: SendCoordinator) {
        #warning("implement")
    }

    func sendCoordinatorCancelled(coordinator: SendCoordinator) {
        if let vc = self.homeVC {
            self.navigationController.popToViewController(vc, animated: true)
        }
    }
}
