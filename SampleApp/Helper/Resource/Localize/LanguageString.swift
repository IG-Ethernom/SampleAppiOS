//
//  LanguageString.swift
//  E-Wallet
//
//  Created by Puttheavy Tep on 24/5/22.
//


import Foundation
enum LanguageString: String {
    // Associate
    case ASSOCIATE_DEVICE = "ASSOCIATE_DEVICE"
    case NO_ASSOCATE_DEVICE = "NO_ASSOCATE_DEVICE"
    case SELECT_DEVICE = "SELECT_DEVICE"
    case CONNECTING_TO = "CONNECTING_TO"
    
    // scan QR code
    case SCAN_QR = "SCAN_QR"
    case SCAN_DEVICE = "SCAN_DEVICE"
    case SCAN_RECIPIENT = "SCAN_RECIPIENT"
    
    // Discover Device
    case DISCOVER_DEVICE = "DISCOVER_DEVICE"
    case DISOCER_GUIDE = "DISOCER_GUIDE"
    case GUIDE_DESC = "GUIDE_DESC"
    
    
    /// ewallet request
    case EWALLET_TIMEOUT = "EWALLET_TIMEOUT"
    case START_EWALLET_LOADING = "START_EWALLET_LOADING"
    
    case CREATE_PASSCODE = "CREATE_PASSCODE"
    case ENTER_PASSCODE = "ENTER_PASSCODE"
    case VERIFY_PASSCODE = "VERIFY_PASSCODE"
    case RETYPE_PASSCODE = "RETYPE_PASSCODE"
    
    /// create wallet
    case CREATE_NEW_WALLET = "CREATE_NEW_WALLET"
    case CREATE_WALLET_LOADING = "CREATE_WALLET_LOADING"
    case CREATE_WALLET_SUCCESS = "CREATE_WALLET_SUCCESS"
    case FINISHED_CREATING = "FINISHED_CREATING"
    case FINISHED_RECOVERING = "FINISHED_RECOVERING"
    
    case WALLET_ALREADY_EXIST = "WALLET_ALREADY_EXIST"
    case CREATE_WALLET_TIMEOUT = "CREATE_WALLET_TIMEOUT"
    case CREATE_WALLET_FAILED = "CREATE_WALLET_FAILED"
    
    
    // recover
    case RECOVER_WALLET = "RECOVER_WALLET"
    case SIGN_IN_WITH_RECOVER_PHARSE = "SIGN_IN_WITH_RECOVER_PHARSE"
    case WORD_PHRASE_INTO = "WORD_PHRASE_INTO"
    case RECOVER_EWALLET_REQUEST = "RECOVER_EWALLET_REQUEST"
    case RECOVER_SUCCESS = "RECOVER_SUCCESS"
    case RECOVER_EMPTY = "RECOVER_EMPTY"
    
    case RECOVER_WALLET_TIMEOUT = "RECOVER_WALLET_TIMEOUT"
    case RECOVER_WALLET_FAILED = "RECOVER_WALLET_FAILED"
    
    case RESTORE_WITH_12_PHRASE = "RESTORE_WITH_12_PHRASE"
    case RESTORE_BUTTON = "RESTORE_BUTTON"
    case CONFIRM_PHARSE_KEY = "CONFIRM_PHARSE_KEY"
    case EMPTY_WALLET = "EMPTY_WALLET"
    
    // delete
    case WIPE_OUT = "WIPE_OUT"
    case WIPE_OUT_TIMEOUT = "WIPE_OUT_TIMEOUT"
    case DELETE_WALLET = "DELETE_WALLET"
    case DELETE_DESCRIPTION = "DELETE_DESCRIPTION"
    case DELETE_TITLE = "DELETE_TITLE"
    case DELETE_MESSAGE = "DELETE_MESSAGE"
    
    ///Check balance
    case CHECK_BALANCE_LOADING = "CHECK_BALANCE_LOADING"
    case CHECKING_BALANCE = "CHECKING_BALANCE"
    case UPDATE_BALANCE = "UPDATE_BALANCE"
    case INQUIRY_TRANSECTION_LOADING = "INQUIRY_TRANSECTION_LOADING"
    case CHECK_BALANCE_TIMEOUT = "CHECK_BALANCE_TIMEOUT"
    case CHECK_BALANCE_FAILED = "CHECK_BALANCE_FAILED"
    
    case YOUR_RECOVER_PHARSE = "YOUR_RECOVER_PHARSE"
    case NEVER_SHARE = "NEVER_SHARE"
    case PLEASE_WRITE_DOWN = "PLEASE_WRITE_DOWN"
    case WRITE_DOWN_KEY = "WRITE_DOWN_KEY"
    case VERIFY_PHARSE_KEY = "VERIFY_PHARSE_KEY"

    //inquiry
    case GET_TRANSECTION_TIMEOUT = "GET_TRANSECTION_TIMEOUT"
    case GET_TRANSECTION_FAILURE = "GET_TRANSECTION_FAILURE"
    
    ///
    ///Create Transection
    case CREATE_TRANSECTION_LOADING = "CREATE_TRANSECTION_LOADING"
    case CREATE_TRANS_FAILED = "CREATE_TRANS_FAILED"
    case VERIFY_PIN_FAILED = "VERIFY_PIN_FAILED"
    case VERIFY_FAILED = "VERIFY_FAILED"
    case SENDING_TIMEOUT = "SENDING_TIMEOUT"
    case TRX_SENT = "TRX_SENT"
    case TRX_DESC = "TRX_DESC"
    
    //get wallet id
    case GET_WALLET_ID_TIMEOUT = "GET_WALLET_ID_TIMEOUT"
    case TOAST_DATA_EMPTY = "TOAST_DATA_EMPTY"
    
    // global
    case CHECK_BALANCE = "CHECK_BALANCE"
    case TOTAL_BALANCE = "TOTAL_BALANCE"
    case SEND = "SEND"
    case SENT = "SENT"
    case SHARE_WALLET = "SHARE_WALLET"
    case COPIED_TO_CLIP = "COPIED_TO_CLIP"
    case SHARE_WALLET_ADDRESS = "SHARE_WALLET_ADDRESS"
    
    case TRANS_EMPTY = "TRANS_EMPTY"
    case TRANSECTION = "TRANSECTION"
    case PLEASE_EXIT_APP = "PLEASE_EXIT_APP"
    case EXIT = "EXIT"
    case Retry = "Retry"
    case okay = "okay"
    case error = "error"
    case next = "next"
    case previous = "previous"
    case continues = "continues"
    case yes = "yes"
    case no = "no"
    case copy = "copy"
    case share = "share"
    case To = "To"
    case Paste = "Paste"
    case scan = "scan"
    case confirm = "confirm"
    case cancel = "cancel"
    case CONFIRM_TRX = "CONFIRM_TRX"
    case invalid_add = "invalid_add"
    case Pasteboard_Desc = "Pasteboard_Desc"
    
    case slow = "slow"
    case medium = "medium"
    case fast = "fast"
    case SEND_TRX = "SEND_TRX"
    case amount = "amount"
    case balance = "balance"
    case GET_BALANCEE = "GET_BALANCEE"
    case NETWORK_FEE = "NETWORK_FEE"
    case FEE_RATE = "FEE_RATE"
    
    case MENU = "MENU"
    case TRX_HISTORY = "TRX_HISTORY"
    case DELETE_WALLET_MENU = "DELETE_WALLET_MENU"
    case ABOUT = "ABOUT"
    case Txid = "Txid"
    case TO_BTC = "TO_BTC"
    case FROM_WALLET = "FROM_WALLET"
    case RECOVER_FROM_WALLET = "RECOVER_FROM_WALLET"
    case TRANSFER_TO = "TRANSFER_TO"
    
     case LATEST_TRX = "LATEST_TRX"
     case latest = "latest"
     case today = "today"
     case weekly = "weekly"
     case monthly = "monthly"
     case yearly = "yearly"
    
    //about
    case ABOUT_EWALLET = "ABOUT_EWALLET"
    case APP_VERSION = "APP_VERSION"
    case CAPSULE_VERSION = "CAPSULE_VERSION"
    case COPY_RIGHT = "COPY_RIGHT"
    case ETHERNOM = "ETHERNOM"
    case ALL_RIGHT = "ALL_RIGHT"
    case TERM_SERVICE = "TERM_SERVICE"
    case PRIVACY_POLICY = "PRIVACY_POLICY"
    
    // send trans
    case INSUFFICIENT_FUNDS = "INSUFFICIENT_FUNDS"
    case INSUFFICIENT_FUNDS_MESSAGE = "INSUFFICIENT_FUNDS_MESSAGE"
    
    case ENTER_AMOUNT = "ENTER_AMOUNT"
    case ENTER_REC = "ENTER_REC"
    case PLEASE_TRY_AGAIN = "PLEASE_TRY_AGAIN"
    case TURN_ON_BLUETOOTH = "TURN_ON_BLUETOOTH"
    case TURN_ON_BLUETOOTH_DESC = "TURN_ON_BLUETOOTH_DESC"
    
    // error message
    case CONNECTION_LOST = "CONNECTION_LOST"
    case CONNECTION_FAILED = "CONNECTION_FAILED"
    case CONNECTION_TIMEOUT = "CONNECTION_TIMEOUT"
    case DISCONNECTING = "DISCONNECTING"
    
    case RECIEVE = "RECIEVE"
    case FROM = "FROM"
    case CLOSE = "CLOSE"
    case CURRENT_BALANCE = "CURRENT_BALANCE"
    case LATEST_BALANCE = "LATEST_BALANCE"
    case SEARCH_FOR_NEARBY = "SEARCH_FOR_NEARBY"
    case CHOOSE_LANGUAGE = "CHOOSE_LANGUAGE"
    case INTERNET = "INTERNET"
    
    case ERROR_RECIPIENT_FORMAT = "ERROR_RECIPIENT_FORMAT"
    case USER_GUIDE = "USER_GUIDE"
    case INVALID_QR = "INVALID_QR"
    case OWN_ADDRESS = "OWN_ADDRESS"
    var LOCALIZE_STRING : String {
        let language = ApplicationSession.shareInstance.getPhoneDefaultLanguage() ?? "en"
        return self.rawValue.addLocalizeString(str: language)
    }
}

