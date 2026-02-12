//
//  HDWalletService.swift
//  Runner
//
//  Created by Ken on 2026/2/10.
//

import Foundation
import WalletCore

struct HDWalletService: HDWalletProtocol {

    func restoreWallet(mnemonic: String, passphrase: String) -> HDWallet? {

        guard validMnemonic(mnemonic) else {
            return nil
        }

        guard let wallet = HDWallet(mnemonic: mnemonic, passphrase: passphrase) else {
            return nil
        }

        return wallet
    }
    
    func createWallet(strength: Int32 = 128, passphrase: String = "") -> HDWallet? {
        guard let wallet = HDWallet(strength: strength, passphrase: passphrase) else {
            return nil
        }
        return wallet
    }
}
