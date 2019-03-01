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

    func homeVCTrxCellTouched(sender: HomeVC, trxDetails: TrxDetails) {
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
            vc.trxHistory = self.trxHistoryProvider.groupedByDate()
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

        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .send,
                                                      date: Date(),
                                                      amount: 22_080_000_000_000_000,
                                                      address: "address send to",
                                                      trxId: "trx id send",
                                                      memo: "memo send"))
        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .receive,
                                                      date: Date(),
                                                      amount: 22_000_000_000_000,
                                                      address: "address received from",
                                                      trxId: "trx id receive",
                                                      memo: "memo receive"))

        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .send,
                                                      date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                                                      amount: 22_080_000_000_000_000,
                                                      address: "address send to",
                                                      trxId: "trx id send",
                                                      memo: "memo send"))
        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .receive,
                                                      date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                                                      amount: 22_000_000_000_000,
                                                      address: "address received from",
                                                      trxId: "trx id receive",
                                                      memo: "memo receive"))

        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .send,
                                                      date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                                                      amount: 22_080_000_000_000_000,
                                                      address: "address send to",
                                                      trxId: "trx id send",
                                                      memo: "memo send"))
        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .receive,
                                                      date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                                                      amount: 22_000_000_000_000,
                                                      address: "address received from",
                                                      trxId: "trx id receive",
                                                      memo: "memo receive"))

        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .send,
                                                      date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                                                      amount: 22_080_000_000_000_000,
                                                      address: "address send to",
                                                      trxId: "trx id send",
                                                      memo: "memo send"))

        trxHistoryProvider.add(trxDetails: TrxDetails(direction: .receive,
                                                      date: Calendar.current.date(byAdding: .day, value: -22, to: Date())!,
                                                      amount: 22_000_000_000_000,
                                                      address: "address received from",
                                                      trxId: "trx id receive",
                                                      memo: "memo receive"))
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
