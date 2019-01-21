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

        #warning("remove")
        self.test_addDummyData()

        let vc = self.viewFactory.getHomeView()
        vc.delegate = self
        vc.localizer = self.localizer
        vc.trxHistoryProvider = self.iocContainer.trxHistoryProvider
        self.navigationController.pushViewController(vc, animated: true)
    }

    private func test_addDummyData() {
        let trxHistoryProvider = self.iocContainer.trxHistoryProvider

        let detailSent = TrxDetail(direction: .send,
                                   date: Date.init(),
                                   amountInAtomicUnits: 2208,
                                   address: "address send to",
                                   trxId: "trx id send",
                                   memo: "memo send")
        let detailReceived = TrxDetail(direction: .receive,
                                       date: Date.init(),
                                       amountInAtomicUnits: 22,
                                       address: "address received from",
                                       trxId: "trx id receive",
                                       memo: "memo receive")
        trxHistoryProvider.add(trxDetail: detailSent)
        trxHistoryProvider.add(trxDetail: detailReceived)
        trxHistoryProvider.add(trxDetail: detailSent)
        trxHistoryProvider.add(trxDetail: detailReceived)
        trxHistoryProvider.add(trxDetail: detailSent)
        trxHistoryProvider.add(trxDetail: detailReceived)
        trxHistoryProvider.add(trxDetail: detailSent)
        trxHistoryProvider.add(trxDetail: detailReceived)
    }
}
