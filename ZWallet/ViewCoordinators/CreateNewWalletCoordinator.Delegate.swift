//
//  CreateNewWalletCoordinator.Delegate.swift
//  ZWallet
//
//  Created by loj on 09.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol CreateNewWalletCoordinatorDelegate: class {
    func createNewWalletCoordinatorSuccessful(coordinator: CreateNewWalletCoordinator)
    func createNewWalletCoordinatorCancelled(coordinator: CreateNewWalletCoordinator)
}
