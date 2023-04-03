//
//  BaseViewModel.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/10/22.
//

import Foundation
class BaseViewModel: NSObject {
  
}


enum APPCmd: UInt8 {
    
    // Ewallet
    case A2C_EWL_REQ = 0x80// E-Wallet Request
    case C2A_EWL_RSP = 0xD0 // E-Wallet Response
    case A2C_EWL_COM = 0x89// E-Wallet Complete
    
    case A2C_EWL_WALLET_ID_REQ = 0x83 // WALLET ID Request
    case C2A_EWL_WALLET_ID_RSP = 0xD3 // WALLET ID Response
}

enum NETWORK_TYPE: String {
    case MAIN_NET = "00"
    case TEST_NET = "6f"
}
