//
//  HDWalletProtocol.swift
//  Runner
//
//  Created by Ken on 2026/2/10.
//

import Foundation
import WalletCore

protocol HDWalletProtocol {
    func restoreWallet(mnemonic: String, passphrase: String) -> HDWallet?
    func createWallet(strength: Int32, passphrase: String) -> HDWallet?
}
