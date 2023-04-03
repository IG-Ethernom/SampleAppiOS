//
//  ErrorModel.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/10/22.
//
import Foundation
struct ToastMessage {
    var show: Bool
    var message: String
}

struct ErrorModel {
    var alert: Bool
    var title: String
    var message: String
    var exit: Bool? = false
    
}

struct LoadingModel {
    var loading: Bool
    var title: String
    var message: String
    
}

struct SuccessModel {
    var alert: Bool
    var title: String
    var message: String
    var action: AlertAction
}

enum AlertAction: String {
    case ok = "Okay"
    case exit = "Exit"
}
