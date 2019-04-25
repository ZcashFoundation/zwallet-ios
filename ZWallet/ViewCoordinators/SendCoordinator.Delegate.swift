//
//  SendCoordinatorDelegate.swift
//  ZWallet
//
//  Created by loj on 03.02.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol SendCoordinatorDelegate: class {
    func sendCoordinatorSuccessful(coordinator: SendCoordinator)
    func sendCoordinatorCancelled(coordinator: SendCoordinator)
}
