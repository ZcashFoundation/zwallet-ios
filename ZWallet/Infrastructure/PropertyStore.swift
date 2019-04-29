//
//  PropertyStore.swift
//  ZWallet
//
//  Created by loj on 29.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


public protocol PropertyStoreProtocol {

    func wipeAll()

    var onboardingIsFinished: Bool { get set }
    var language: String { get set }
    var currency: String { get set }
    var nodeAddress: String { get set }
    var lastFiatUpdate: Date? { get set }
    var lastFiatFactor: Double? { get set }
    var feeInAtomicUnits: UInt64 { get set }
}


public class PropertyStore: PropertyStoreProtocol {

    private let TagOnboardingIsFinished = "OnboardingIsFinished"
    private let TagLanguage = "Language"
    private let TagCurrency = "Currency"
    private let TagNodeAddress = "NodeAddress"
    private let TagLastFiatUpdate = "FiatUpdate"
    private let TagLastFiatFactor = "FiatFactor"
    private let TagFeeInAtomicUnits = "FeeInAtomicUnits"

    private let defaultStore = UserDefaults.standard

    public init() {
    }

    public func wipeAll() {
    }

    public var onboardingIsFinished: Bool {
        get {
            if let onboardingFinished = self.defaultStore.object(forKey: TagOnboardingIsFinished) as? Bool {
                return onboardingFinished
            }
            return false
        }
        set {
            self.defaultStore.set(newValue, forKey: TagOnboardingIsFinished)
        }
    }

    public var language: String {
        get {
            if let language = self.defaultStore.object(forKey: TagLanguage) as? String {
                return language
            }
            return Localization.initialLanguage()
        }
        set {
            self.defaultStore.set(newValue, forKey: TagLanguage)
        }
    }

    public var currency: String {
        get {
            if let currency = self.defaultStore.object(forKey: TagCurrency) as? String {
                return currency
            }
            return Constants.defaultCurrency
        }
        set {
            self.defaultStore.set(newValue, forKey: TagCurrency)
        }
    }

    public var nodeAddress: String {
        get {
            if let nodeAddress = self.defaultStore.object(forKey: TagNodeAddress) as? String {
                return nodeAddress
            }
            return Constants.defaultNodeAddress
        }
        set {
            self.defaultStore.set(newValue, forKey: TagNodeAddress)
        }
    }

    public var lastFiatUpdate: Date? {
        get {
            if let fiatUpdate = self.defaultStore.object(forKey: TagLastFiatUpdate) as? Date? {
                return fiatUpdate
            }
            return nil
        }
        set {
            self.defaultStore.set(newValue, forKey: TagLastFiatUpdate)
        }
    }

    public var lastFiatFactor: Double? {
        get {
            if let fiatFactor = self.defaultStore.object(forKey: TagLastFiatFactor) as? Double? {
                return fiatFactor
            }
            return nil
        }
        set {
            self.defaultStore.set(newValue, forKey: TagLastFiatFactor)
        }
    }

    public var feeInAtomicUnits: UInt64 {
        get {
            if let fee = self.defaultStore.object(forKey: TagFeeInAtomicUnits) as? UInt64 {
                return fee
            }
            return 0
        }
        set {
            self.defaultStore.set(newValue, forKey: TagFeeInAtomicUnits)
        }
    }
}
