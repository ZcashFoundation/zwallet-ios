//
//  IocContainer.swift
//  ZWallet
//
//  Created by loj on 06.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol IocContainerProtocol {

    var localizer: Localizable { get }
}


internal class IocContainer: IocContainerProtocol {

    public static let instance = IocContainer()

    public lazy var localizer: Localizable = {
        let localizer = Localization()
        return localizer
    }()
}
