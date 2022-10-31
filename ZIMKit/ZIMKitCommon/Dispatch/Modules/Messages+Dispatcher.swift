//
//  Messages+Dispatcher.swift
//  Pods-ZIMKitDemo
//
//  Created by Kael Ding on 2022/7/29.
//

import Foundation
import ZIM

public enum MessagesDispatcher: DispatchProtocol {
    case messagesList(_ conversationID: String,
                      _ type: ZIMConversationType,
                      _ conversationName: String)
}

public enum MessagesActionDispatcher: DispatchProtocol {

}
