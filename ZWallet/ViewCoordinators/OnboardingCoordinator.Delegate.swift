//
//  OnboardingCoordinator.Delegate.swift
//  ZWallet
//
//  Created by loj on 07.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinatorSuccessful(coordinator: OnboardingCoordinator)
}
